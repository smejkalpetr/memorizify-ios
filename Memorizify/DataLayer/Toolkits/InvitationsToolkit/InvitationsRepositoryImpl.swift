//
//  InvitationsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation
import Firebase

/// Implementation of the InvitationsRepository protocol.
struct InvitationsRepositoryImpl: InvitationsRepository {
    
    private let authenticationRepository: AuthenticationRepository
    private let userRepository: UserRepository
    private let guildsRepository: GuildsRepository
    
    /// Initializes a new instance of InvitationsRepositoryImpl.
    /// - Parameters:
    ///   - authenticationRepository: The repository for authentication operations.
    ///   - userRepository: The repository for user-related operations.
    ///   - guildsRepository: The repository for guild-related operations.
    init(authenticationRepository: AuthenticationRepository, userRepository: UserRepository, guildsRepository: GuildsRepository) {
        self.authenticationRepository = authenticationRepository
        self.userRepository = userRepository
        self.guildsRepository = guildsRepository
    }
    
    /// Adds an invitation asynchronously.
    /// - Parameters:
    ///   - email: The email of the invited user.
    ///   - guildId: The ID of the guild.
    ///   - guildName: The name of the guild.
    ///   - date: The date of the invitation.
    func add(to email: String, guildId: String, guildName: String, at date: Date) async throws {
        let db = Firestore.firestore()
        
        let user = try await userRepository.getCurrentUser()
        let invitedUser = try await userRepository.getUser(with: email)
        
        // Check whether user already member of a guild
        if let usersGuilds = try await guildsRepository.getAllGuildsForUser(with: invitedUser.email) {
            guard !usersGuilds.contains(where: { $0.id == guildId && $0.board.records.contains(where: { $0.uid == invitedUser.uid }) }) else { throw InvitationsError.alreadyMember }
        }
        
        // Check whether user already has a pending invitation to this guild
        let usersInvitations = try await getInvitationsForUser(with: email)
        guard !usersInvitations.contains(where: { $0.guildId == guildId }) else { throw InvitationsError.alreadyInvited }
        
        let invitation = Invitation(email: email, guildId: guildId, guildName: guildName, senderUsername: user.username, senderUid: user.uid, date: date)
               
        let invitationDict = try Firestore.Encoder().encode(invitation)
        
        let collectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Save Invitation to the 'invitations' collection
        MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: collectionRef.path + "/newDocument", data: invitationDict)
        try await collectionRef.addDocument(data: invitationDict)
    }
    
    /// Retrieves all invitations asynchronously.
    /// - Returns: An array of invitations.
    func getAll() async throws -> [Invitation] {
        let db = Firestore.firestore()
        
        var invitations: [Invitation] = []
        
        // Make reference to invitations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: invitationsCollectionRef.path)
        let querySnapshot = try await invitationsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Invitation objects
        for document in querySnapshot.documents {
            let invitation = try document.data(as: Invitation.self)
            invitations.append(invitation)
        }
        
        return invitations
    }
    
    /// Retrieves invitations for a specific user asynchronously.
    /// - Parameter email: The email of the user.
    /// - Returns: An array of invitations for the user.
    func getInvitationsForUser(with email: String) async throws -> [Invitation] {
        let db = Firestore.firestore()
        
        let user = try await userRepository.getUser(with: email)
        
        var invitations: [Invitation] = []
        
        // Make reference to invitations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: invitationsCollectionRef.path)
        let querySnapshot = try await invitationsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Invitation objects
        for document in querySnapshot.documents {
            let invitation = try document.data(as: Invitation.self)
            invitations.append(invitation)
        }
        
        // Delete invitations which are older than 48 hours
        for invitation in invitations {
            if let diff = Calendar.current.dateComponents([.hour], from: invitation.date, to: Date()).hour, diff > 48 {
                try await delete(invitation)
            }
        }
        
        // Filter out invitations (those which contain user's uid)
        var filteredInvitations: [Invitation] = []
        for invitation in invitations {
            let invitedUser = try await userRepository.getUser(with: invitation.email)
            
            if invitedUser.uid == user.uid {
                filteredInvitations.append(invitation)
            }
        }
        
        return filteredInvitations
    }
    
    /// Retrieves invitations for the current user asynchronously.
    /// - Returns: An array of invitations for the current user.
    func getMyInvitations() async throws -> [Invitation] {
        let user = try await userRepository.getCurrentUser()
        return try await getInvitationsForUser(with: user.email)
    }
    
    /// Accepts an invitation asynchronously.
    /// - Parameter invitation: The invitation to accept.
    func accept(_ invitation: Invitation) async throws {
        // Delete the invitation from invitations collection
        try await delete(invitation)
        
        // Get User
        let user = try await userRepository.getCurrentUser()
        
        // Fetch all guilds
        guard let guilds = try await guildsRepository.getAllGuilds() else { throw InvitationsError.noGuildsFound }
        
        guard let searchedGuild = guilds.first(where: { $0.id == invitation.guildId }) else { throw InvitationsError.noGuildsFound }
        
        // Check whether invited user is already a member
        guard !searchedGuild.board.records.contains(where: { $0.uid == user.uid }) else { throw InvitationsError.alreadyMember }
        
        var newBoard = searchedGuild.board
        newBoard.records.append(
            BoardRecord(
                uid: user.uid,
                username: user.username,
                score: 0.0
            )
        )
        
        let newGuild = Guild(copy: searchedGuild, board: newBoard)
        try await guildsRepository.update(newGuild)
        
        // Update User entity
        var newGuildIds = user.guildIds ?? []
        newGuildIds.append(searchedGuild.id)
        
        let newUser = User(copy: user, guildIds: newGuildIds)
        try await userRepository.update(user: newUser)
    }
    
    /// Declines an invitation asynchronously.
    /// - Parameter invitation: The invitation to decline.
    func decline(_ invitation: Invitation) async throws {
        try await delete(invitation)
    }
    
    /// Updates an invitation asynchronously.
    /// - Parameter invitation: The invitation to update.
    func update(_ invitation: Invitation) async throws {
        let db = Firestore.firestore()

        // Make reference to invitations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
    
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: invitationsCollectionRef.path)
        let querySnapshot = try await invitationsCollectionRef.getDocuments()

        // Iterate through the documents, find and delete the invitation
        for document in querySnapshot.documents {
            let searchedInvitation = try document.data(as: Invitation.self)
            
            if searchedInvitation == invitation {
                let invitationDict = try Firestore.Encoder().encode(invitation)
                let documentRef = invitationsCollectionRef.document(document.documentID)
                MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: invitationDict)
                try await documentRef.setData(invitationDict)
                break
            }
        }
    }
    
    /// Deletes all invitations for a specific guild asynchronously.
    /// - Parameter guild: The guild for which invitations should be deleted.
    func deleteAllForGuild(_ guild: Guild) async throws {
        let invitations = try await getAll()
        
        let myGuildInvitations = invitations.filter { $0.guildId == guild.id }
        
        for invitation in myGuildInvitations {
            try await delete(invitation)
        }
    }
    
    /// Deletes all invitations for a specific user asynchronously.
    /// - Parameter userUid: The UID of the user for whom invitations should be deleted.
    func deleteAll(of userUid: String) async throws {
        let db = Firestore.firestore()

        // Make reference to invitations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Get the user's email
        let email = try await userRepository.getUser(uid: userUid).email
    
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: invitationsCollectionRef.path)
        let querySnapshot = try await invitationsCollectionRef.getDocuments()

        // Iterate through the documents, find and delete the user's invitations
        for document in querySnapshot.documents {
            let searchedInvitation = try document.data(as: Invitation.self)
            
            if searchedInvitation.email == email || searchedInvitation.senderUid == userUid {
                try await delete(searchedInvitation)
            }
        }
    }
    
    // MARK: Private
    
    /// Deletes an invitation asynchronously.
    /// - Parameter invitation: The invitation to delete.
    private func delete(_ invitation: Invitation) async throws {
        let db = Firestore.firestore()

        // Make reference to invitations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
    
        // Fetch all documents from the collection
        let querySnapshot = try await invitationsCollectionRef.getDocuments()

        // Iterate through the documents, find and delete the invitation
        for document in querySnapshot.documents {
            let searchedInvitation = try document.data(as: Invitation.self)
            
            if searchedInvitation == invitation {
                let documentRef = invitationsCollectionRef.document(document.documentID)
                MemorizifyLogger.logDocumentsDelete(file: #file, line: #line, documentPath: documentRef.path)
                try await documentRef.delete()
                break
            }
        }
    }
}
