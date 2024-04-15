//
//  AuthenticationRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Firebase

protocol AuthenticationRepository {
    func getUser() -> FirebaseUser?
    func signUp(data: SignUpData) async throws -> FirebaseUser
    func signOut() throws
    func sendEmailVerification() async throws
    func logIn(with data: LogInData) async throws
    func logOut() throws
    func isUserLoggedIn() -> Bool
    func resetPassword(with email: String) async throws
}
