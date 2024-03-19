//
//  LogOutUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 19.03.2024.
//

protocol LogOutUseCase {
    func execute() throws
}

struct LogOutUseCaseImpl: LogOutUseCase {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func execute() throws {
        try authenticationRepository.logOut()
    }
}
