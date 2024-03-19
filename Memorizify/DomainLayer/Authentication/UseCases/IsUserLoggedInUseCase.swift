//
//  IsUserLoggedInUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

protocol IsUserLoggedInUseCase {
    func execute() -> Bool
}

struct IsUserLoggedInUseCaseImpl: IsUserLoggedInUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() -> Bool {
        return authenticationRepository.isUserLoggedIn()
    }
}
