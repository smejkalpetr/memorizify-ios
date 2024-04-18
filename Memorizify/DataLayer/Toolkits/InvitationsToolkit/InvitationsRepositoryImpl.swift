//
//  InvitationsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation
import Firebase

struct InvitationsRepositoryImpl: InvitationsRepository {
    
    private let authenticationRepository: AuthenticationRepository
    private let userRepository: UserRepository
    private let guildsRepository: GuildsRepository
        
    init(authenticationRepository: AuthenticationRepository, userRepository: UserRepository, guildsRepository: GuildsRepository) {
        self.authenticationRepository = authenticationRepository
        self.userRepository = userRepository
        self.guildsRepository = guildsRepository
    }
    
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
        
        #warning("FIXME: Remove hard-coded strings when localization is available!")
        let invitation = Invitation(email: email, guildId: guildId, guildName: guildName, senderNickname: user.nickname ?? "Anonymous", senderUid: user.uid, date: date)
               
        let invitationDict = try Firestore.Encoder().encode(invitation)
        
        // Save Invation to the 'invitations' collection
        try await db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
                    .addDocument(data: invitationDict)
    }
    
    func getAll() async throws -> [Invitation] {
        let db = Firestore.firestore()
        
        var invitations: [Invitation] = []
        
        // Make reference to invtiations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Fetch all documents from the collection
        let querySnapshot = try await invitationsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Invitation objects
        for document in querySnapshot.documents {
            let invitation = try document.data(as: Invitation.self)
            invitations.append(invitation)
        }
        
        return invitations
    }
    
    func getInvitationsForUser(with email: String) async throws -> [Invitation] {
        let db = Firestore.firestore()
        
        let user = try await userRepository.getUser(with: email)
        
        var invitations: [Invitation] = []
        
        // Make reference to invtiations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
        
        // Fetch all documents from the collection
        let querySnapshot = try await invitationsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Invitation objects
        for document in querySnapshot.documents {
            let invitation = try document.data(as: Invitation.self)
            invitations.append(invitation)
        }
        
        // Delete invtations which are older than 48 hours
        for invitation in invitations {
            if let diff = Calendar.current.dateComponents([.hour], from: invitation.date, to: Date()).hour, diff > 48 {
                try await delete(invitation)
            }
        }
        
        // Filter out invitaions (those which contain user's uid)
        var filteredInvitations: [Invitation] = []
        for invitation in invitations {
            let invitedUser = try await userRepository.getUser(with: invitation.email)
            
            if invitedUser.uid == user.uid {
                filteredInvitations.append(invitation)
            }
        }
        
        return filteredInvitations
    }
    
    func getMyInvitations() async throws -> [Invitation] {
        let user = try await userRepository.getCurrentUser()
        return try await getInvitationsForUser(with: user.email)
    }
    
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
        #warning("FIXME: Remove hard-coded strings when localization is available!")
        newBoard.records.append(
            BoardRecord(
                uid: user.uid,
                nickname: user.nickname ?? "Anonymous",
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
    
    func decline(_ invitation: Invitation) async throws {
        try await delete(invitation)
    }
    
    func update(_ invitation: Invitation) async throws {
        let db = Firestore.firestore()

        // Make reference to invtiations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
    
        // Fetch all documents from the collection
        let querySnapshot = try await invitationsCollectionRef.getDocuments()

        // Iterate through the documents, find and delete the invitation
        for document in querySnapshot.documents {
            let searchedInvitation = try document.data(as: Invitation.self)
            
            if searchedInvitation == invitation {
                let invitationDict = try Firestore.Encoder().encode(invitation)
                try await invitationsCollectionRef.document(document.documentID).setData(invitationDict)
                break
            }
        }
    }
    
    func deleteAllForGuild(_ guild: Guild) async throws {
        let invitations = try await getAll()
        
        let myGuildInvitations = invitations.filter { $0.guildId == guild.id }
        
        for invitation in myGuildInvitations {
            try await delete(invitation)
        }
    }
    
    // MARK: Private
    
    private func delete(_ invitation: Invitation) async throws {
        let db = Firestore.firestore()

        // Make reference to invtiations collection
        let invitationsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_INVITATIONS)
    
        // Fetch all documents from the collection
        let querySnapshot = try await invitationsCollectionRef.getDocuments()

        // Iterate through the documents, find and delete the invitation
        for document in querySnapshot.documents {
            let searchedInvitation = try document.data(as: Invitation.self)
            
            if searchedInvitation == invitation {
                try await invitationsCollectionRef.document(document.documentID).delete()
                break
            }
        }
    }
}
