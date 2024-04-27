//
//  AuthenticationRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Firebase

struct AuthenticationRepositoryImpl: AuthenticationRepository {
    
    func getUser() throws -> FirebaseUser {
        try getFirebaseUser()
    }
    
    func signUp(data: SignUpData) async throws -> FirebaseUser {
        // Create a new user in Authentication
        let authResult = try await Auth.auth().createUser(withEmail: data.email, password: data.password)
        
        // Store user data in Firestore
        let db = Firestore.firestore()
        
        // Encode User model as [String: Any]
        let userDict = try Firestore.Encoder().encode(
            User(
                uid: authResult.user.uid,
                username: data.username,
                email: data.email,
                score: 0
            )
        )
        
        let documentRef = db.collection(Constants.FIREBASE_COLLECTION_USERS).document(authResult.user.uid)
        
        MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: userDict)
        try await documentRef.setData(userDict)
        
        return authResult.user
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
        guard let user = try? getUser() else { return false }
        return user.isEmailVerified
    }
    
    func resetPassword(with email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func changePassword(from currentPassword: String, to newPassword: String) async throws {
        // Get Firebase user
        let firUser = try getUser()
        
        // Re-authenticate (required by Firebase for sensitive actions)
        guard let email = firUser.email else { throw FirebaseUserError.emailMissing }
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        try await firUser.reauthenticate(with: credential)
        
        // Update password
        try await firUser.updatePassword(to: newPassword)
    }
    
    func deleteAccountOfCurrentUser(password: String) async throws {
        // Get the Firebase user
        let firUser = try getUser()
        
        // Reauthenticate user
        guard let email = firUser.email else { throw FirebaseUserError.emailMissing }
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        try await firUser.reauthenticate(with: credential)
        
        // Delete the user account
        try await firUser.delete()
    }
    
    func checkPassword(_ password: String) async throws {
        // Get the Firebase user
        let firUser = try getUser()
        
        do {
            // Reauthenticate user to check password
            guard let email = firUser.email else { throw FirebaseUserError.emailMissing }
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            try await firUser.reauthenticate(with: credential)
        } catch {
            throw AuthenticationError.wrongPassword
        }
    }
    
    // MARK: Private
    
    private func getFirebaseUser() throws -> FirebaseUser {
        guard let user = Auth.auth().currentUser else {
            throw FirebaseUserError.notFound
        }
        
        return user
    }
}
