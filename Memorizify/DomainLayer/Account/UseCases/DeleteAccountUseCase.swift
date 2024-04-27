//
//  DeleteAccountUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

/// Protocol for deleting user account.
protocol DeleteAccountUseCase {
    
    /// Deletes the user account.
    /// - Parameter password: The password of the user.
    func execute(password: String) async throws
}

/// Implementation of `DeleteAccountUseCase`.
struct DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    
    private let storylinesRepository: StorylinesRepository
    private let invitationsRepository: InvitationsRepository
    private let guildsRepository: GuildsRepository
    private let userRepository: UserRepository
    private let authenticationRepository: AuthenticationRepository
    private let checkPasswordUseCase: CheckPasswordUseCase
    
    /// Initializes the use case.
    /// - Parameters:
    ///   - storylinesRepository: Repository for managing storylines.
    ///   - invitationsRepository: Repository for managing invitations.
    ///   - guildsRepository: Repository for managing guilds.
    ///   - userRepository: Repository for managing user data.
    ///   - authenticationRepository: Repository for managing authentication.
    ///   - checkPasswordUseCase: Use case for checking the user's password.
    init(
        storylinesRepository: StorylinesRepository,
        invitationsRepository: InvitationsRepository,
        guildsRepository: GuildsRepository,
        userRepository: UserRepository,
        authenticationRepository: AuthenticationRepository,
        checkPasswordUseCase: CheckPasswordUseCase
    ) {
        self.storylinesRepository = storylinesRepository
        self.invitationsRepository = invitationsRepository
        self.guildsRepository = guildsRepository
        self.userRepository = userRepository
        self.authenticationRepository = authenticationRepository
        self.checkPasswordUseCase = checkPasswordUseCase
    }
    
    /// Deletes the user account.
    /// - Parameter password: The password of the user.
    func execute(password: String) async throws {
        // Check if user has provided correct password
        try await checkPasswordUseCase.execute(password: password)
        
        // Get current user
        if let user = try? await userRepository.getCurrentUser() {
            // Delete all storylines, invitations, and guilds associated with the user
            try? await storylinesRepository.deleteAll(of: user.uid)
            try? await invitationsRepository.deleteAll(of: user.uid)
            try? await guildsRepository.deleteAll(of: user.uid)
            
            // Delete user data
            try? await userRepository.delete(user: user)
        }
        
        // Delete account (from Firebase Authentication)
        try await authenticationRepository.deleteAccountOfCurrentUser(password: password)
    }
}
