//
//  UserRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 14.04.2024.
//

import Firebase

struct UserRepositoryImpl: UserRepository {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func getCurrentUser() async throws -> User {
        let db = Firestore.firestore()
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        guard let user = authenticationRepository.getUser() else { throw FirebaseUserError.notFound }

        let documentReference = usersCollectionRef.document(user.uid)
        let documentSnapshot = try await documentReference.getDocument()
        
        return try documentSnapshot.data(as: User.self)
    }
    
    func update(user: User) async throws {
        let db = Firestore.firestore()
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
        
        guard let firUser = authenticationRepository.getUser() else { throw FirebaseUserError.notFound }

        let documentReference = usersCollectionRef.document(firUser.uid)
        
        let userDict = try Firestore.Encoder().encode(user)
        try await documentReference.setData(userDict)
    }
}
