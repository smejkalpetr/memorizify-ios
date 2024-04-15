//
//  AuthenticationRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Firebase

struct AuthenticationRepositoryImpl: AuthenticationRepository {
    
    func getUser() -> FirebaseUser? {
        return Auth.auth().currentUser
    }
    
    func signUp(data: SignUpData) async throws -> FirebaseUser {
        // Create a new user in Authentication
        let authResult = try await Auth.auth().createUser(withEmail: data.email, password: data.password)
        
        // Store user data in Firestore
        let db = Firestore.firestore()
        
        // Encode User model as [String: Any]
        let userDict = try Firestore.Encoder().encode(User(name: data.name, email: data.email, score: 0))
        
        try await db.collection(Constants.FIREBASE_COLLECTION_USERS)
            .document(authResult.user.uid)
            .setData(userDict)
        
        return authResult.user
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func sendEmailVerification() async throws {
        let user = try getFirebaseUser()
        guard !user.isEmailVerified else { throw FirebaseUserError.alreadyVerified }
        try await user.sendEmailVerification()
    }
    
    func logIn(with data: LogInData) async throws {
        try await Auth.auth().signIn(withEmail: data.email, password: data.password)
        let user = try getFirebaseUser()
        guard user.isEmailVerified else { throw FirebaseUserError.emailNotVerified }
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func resetPassword(with email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    // MARK: Private
    
    private func getFirebaseUser() throws -> FirebaseUser {
        guard let user = Auth.auth().currentUser else {
            throw FirebaseUserError.notFound
        }
        
        return user
    }
    
}
