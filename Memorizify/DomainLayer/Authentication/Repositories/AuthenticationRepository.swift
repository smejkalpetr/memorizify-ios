//
//  AuthenticationRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

protocol AuthenticationRepository {
    func getUser() throws -> FirebaseUser
    func signUp(data: SignUpData) async throws -> FirebaseUser
    func sendEmailVerification() async throws
    func logIn(with data: LogInData) async throws
    func logOut() throws
    func isUserLoggedIn() -> Bool
    func resetPassword(with email: String) async throws
    func changePassword(from currentPassword: String, to newPassword: String) async throws
    func deleteAccountOfCurrentUser(password: String) async throws
    func checkPassword(_ password: String) async throws
}
