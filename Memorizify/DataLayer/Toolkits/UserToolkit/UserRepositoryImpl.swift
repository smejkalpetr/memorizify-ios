//
//  UserRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

import Firebase

/// Implementation of the UserRepository protocol.
struct UserRepositoryImpl: UserRepository {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes a new instance of UserRepositoryImpl.
    /// - Parameter authenticationRepository: The repository for authentication operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Retrieves the current user asynchronously.
    /// - Returns: The current user.
    func getCurrentUser() async throws -> User {
        let db = Firestore.firestore()
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        let firUser = try authenticationRepository.getUser()

        let documentReference = usersCollectionRef.document(firUser.uid)
        let documentSnapshot = try await documentReference.getDocument()
        
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: documentReference.path)
        return try documentSnapshot.data(as: User.self)
    }
    
    /// Retrieves a user with the specified email address asynchronously.
    /// - Parameter email: The email address of the user to retrieve.
    /// - Returns: The user with the specified email address.
    func getUser(with email: String) async throws -> User {
        let db = Firestore.firestore()
        
        // Make reference to users collection
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        let user = try authenticationRepository.getUser()
        
        // Fetch all documents from the collection
        
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: usersCollectionRef.path)
        let querySnapshot = try await usersCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let searchedUser = try document.data(as: User.self)
            if searchedUser.email == email {
                return searchedUser
            }
        }
        
        throw UserError.notFound
    }
    
    /// Retrieves a user with the specified UID asynchronously.
    /// - Parameter uid: The UID of the user to retrieve.
    /// - Returns: The user with the specified UID.
    func getUser(uid: String) async throws -> User {
        let db = Firestore.firestore()
        
        // Make reference to users collection
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        let user = try authenticationRepository.getUser()
        
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: usersCollectionRef.path)
        let querySnapshot = try await usersCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let searchedUser = try document.data(as: User.self)
            if searchedUser.uid == uid {
                return searchedUser
            }
        }
        
        throw UserError.notFound
    }
    
    /// Updates the user asynchronously.
    /// - Parameter user: The user to update.
    func update(user: User) async throws {
        let db = Firestore.firestore()
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: usersCollectionRef.path, description: "Where Field 'uid' == \(user.uid)")
        let query = usersCollectionRef.whereField("uid", isEqualTo: user.uid)
        
        let querySnapshot = try await query.getDocuments()
        
        // Iterate through the documents and decode them into Guild objects
        for document in querySnapshot.documents {
            let userDict = try Firestore.Encoder().encode(user)
            let documentRef = usersCollectionRef.document(document.documentID)
            MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: userDict)
            try await documentRef.setData(userDict)
        }
    }
    
    /// Removes a guild for the current user asynchronously.
    /// - Parameter guild: The guild to remove.
    func removeGuildForCurrentUser(_ guild: Guild) async throws {
        // Remove guild from User entity
        let user = try await getCurrentUser()
        
        var newGuildIds = user.guildIds
        newGuildIds?.removeAll { $0 == guild.id }
        
        let newUser = User(copy: user, guildIds: newGuildIds)
        try await update(user: newUser)
    }
    
    /// Deletes a user asynchronously.
    /// - Parameter user: The user to delete.
    func delete(user: User) async throws {
        let db = Firestore.firestore()
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        // Fetch all documents from the collection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: usersCollectionRef.path, description: "Where Field 'uid' == \(user.uid)")
        let query = usersCollectionRef.whereField("uid", isEqualTo: user.uid)
        
        let querySnapshot = try await query.getDocuments()
        
        // Iterate through the documents and delete them
        for document in querySnapshot.documents {
            try await document.reference.delete()
        }
    }
}
