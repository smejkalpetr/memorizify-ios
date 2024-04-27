//
//  AuthenticationRepository.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

/// Repository for authentication-related operations.
protocol AuthenticationRepository {
    
    /// Retrieves the current user.
    /// - Returns: The current user.
    func getUser() throws -> FirebaseUser
    
    /// Signs up a new user.
    /// - Parameter data: The signup data.
    /// - Returns: The newly created user.
    func signUp(data: SignUpData) async throws -> FirebaseUser
    
    /// Sends email verification to the user.
    func sendEmailVerification() async throws
    
    /// Logs in a user.
    /// - Parameter data: The login data.
    func logIn(with data: LogInData) async throws
    
    /// Logs out the current user.
    func logOut() throws
    
    /// Checks if a user is currently logged in.
    /// - Returns: `true` if the user is logged in, otherwise `false`.
    func isUserLoggedIn() -> Bool
    
    /// Sends a password reset email to the provided email address.
    /// - Parameter email: The email address for password reset.
    func resetPassword(with email: String) async throws
    
    /// Changes the password of the current user.
    /// - Parameters:
    ///   - currentPassword: The current password.
    ///   - newPassword: The new password.
    func changePassword(from currentPassword: String, to newPassword: String) async throws
    
    /// Deletes the account of the current user.
    /// - Parameter password: The password of the current user for account deletion.
    func deleteAccountOfCurrentUser(password: String) async throws
    
    /// Checks the strength of a password.
    /// - Parameter password: The password to check.
    func checkPassword(_ password: String) async throws
}
