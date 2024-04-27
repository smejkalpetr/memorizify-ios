//
//  DeleteAccountUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 27.04.2024.
//

protocol DeleteAccountUseCase {
    func execute(password: String) async throws
}

struct DeleteAccountUseCaseImpl: DeleteAccountUseCase {
    
    private let storylinesRepository: StorylinesRepository
    private let invitationsRepository: InvitationsRepository
    private let guildsRepository: GuildsRepository
    private let userRepository: UserRepository
    private let authenticationRepository: AuthenticationRepository
    private let checkPasswordUseCase: CheckPasswordUseCase
    
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
    
    func execute(password: String) async throws {
        // Check if user has provided correct password
        try await checkPasswordUseCase.execute(password: password)
        
        if let user = try? await userRepository.getCurrentUser() {
            // Delete all storylines
            try? await storylinesRepository.deleteAll(of: user.uid)
            
            // Delete all invitations
            try? await invitationsRepository.deleteAll(of: user.uid)
            
            // Delete all guilds
            try? await guildsRepository.deleteAll(of: user.uid)
            
            // Delete user
            try? await userRepository.delete(user: user)
        }
        
        // Delete account (from Firebase Authentication)
        try await authenticationRepository.deleteAccountOfCurrentUser(password: password)
    }
}
