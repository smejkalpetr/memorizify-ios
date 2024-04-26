//
//  GuildsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

import Foundation
import Firebase

struct GuildsRepositoryImpl: GuildsRepository {
    
    private let authenticationRepository: AuthenticationRepository
    private let userRepository: UserRepository
    
    init(authenticationRepository: AuthenticationRepository, userRepository: UserRepository) {
        self.authenticationRepository = authenticationRepository
        self.userRepository = userRepository
    }
    
    func add(name: String, goal: TimeInterval, storylineKindRawValue: String) async throws -> String {
        let db = Firestore.firestore()
        
        let user = try await userRepository.getCurrentUser()
        
        guard let storylineKind = StorylineKind(rawValue: storylineKindRawValue) else { throw StorylinesError.failedToInitializeFromRawValue }
               
        // Save new Guild
        let guild = Guild(
            name: name,
            board: Board(
                records: [
                    BoardRecord(uid: user.uid, username: user.username, score: 0.0, isLeader: true)
                ]
            ),
            leaderUid: user.uid,
            goal: goal,
            storylineKind: storylineKind
        )
        
        let guildDict = try Firestore.Encoder().encode(guild)
        
        let documentRef = db.collection(Constants.FIREBASE_COLLECTION_GUILDS).document(guild.id)
                    
        MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: guildDict)
        try await documentRef.setData(guildDict)
        
        // Save new guildId to User entity
        var userGuilds = user.guildIds ?? []
        userGuilds.append(guild.id)
        
        let newUser = User(copy: user, guildIds: userGuilds)
        
        try await userRepository.update(user: newUser)
        
        return guild.id
    }
    
    func getAllGuildsForUser(with email: String) async throws -> [Guild]? {
        guard let guilds = try await getAllGuilds() else { return nil }
        
        // Get my guildIds stored in User entity
        let user = try await userRepository.getUser(with: email)
        
        guard let guildIds = user.guildIds else { return nil }
        
        // Filter out my guilds - those which have their id
        // in the guildIds collection on the User object
        return guilds.filter { guildIds.contains($0.id) }
    }
    
    func getMyGuilds() async throws -> [Guild]? {
        let user = try await userRepository.getCurrentUser()
        return try await getAllGuildsForUser(with: user.email)
    }
    
    func getAllGuilds() async throws -> [Guild]? {
        let db = Firestore.firestore()
        
        var guilds: [Guild] = []
        
        // Make reference to guilds collection
        let guildsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_GUILDS)
    
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: guildsCollectionRef.path)
        let querySnapshot = try await guildsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let guild = try document.data(as: Guild.self)
            guilds.append(guild)
        }
        
        return guilds.isEmpty ? nil : guilds
    }
    
    func update(_ guild: Guild) async throws {
        try await delete(guild)
        try await add(guild)
    }
    
    func delete(_ guild: Guild) async throws {
        let db = Firestore.firestore()
        
        // Make reference to guilds collection
        let guildsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_GUILDS)
    
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: guildsCollectionRef.path)
        let querySnapshot = try await guildsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let searchedGuild = try document.data(as: Guild.self)
            if searchedGuild.id == guild.id {
                try await guildsCollectionRef.document(document.documentID).delete()
                break
            }
        }
    }
    
    func add(_ guild: Guild) async throws {
        let db = Firestore.firestore()
        
        let user = try await userRepository.getCurrentUser()
        
        let guildDict = try Firestore.Encoder().encode(guild)
        
        let documentRef = db.collection(Constants.FIREBASE_COLLECTION_GUILDS).document(guild.id)
        
        MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: guildDict)
        try await documentRef.setData(guildDict)
        
        // Save new guildId to User entity
        var userGuilds = user.guildIds ?? []
        userGuilds.append(guild.id)
        
        let newUser = User(copy: user, guildIds: userGuilds)
        
        try await userRepository.update(user: newUser)
    }
    
    func load(_ guild: Guild) async throws -> Guild {
        let db = Firestore.firestore()
        
        // Make reference to guilds collection
        let guildsCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_GUILDS)
    
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: guildsCollectionRef.path)
        let querySnapshot = try await guildsCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let searchedGuild = try document.data(as: Guild.self)
            if searchedGuild.id == guild.id {
                return searchedGuild
            }
        }
        
        throw GuildsError.notFound
    }
}
