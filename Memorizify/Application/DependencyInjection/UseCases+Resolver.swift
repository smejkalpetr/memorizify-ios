//
//  UseCases+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Resolver

public extension Resolver {
    static func registerUseCases() {
        
        // Authentication
        register { ValidateNameUseCaseImpl() as ValidateNameUseCase }
        
        register { ValidateEmailUseCaseImpl() as ValidateEmailUseCase }
        
        register { ValidatePasswordUseCaseImpl() as ValidatePasswordUseCase }
        
        register { ValidateRepeatedPasswordImpl() as ValidateRepeatedPasswordUseCase }
        
        register { SendEmailVerificationUseCaseImpl(authenticationRepository: resolve()) as SendEmailVerificationUseCase }
        
        register { SignUpUseCaseImpl(authenticationRepository: resolve(), sendEmailVerificationUseCase: resolve()) as SignUpUseCase }
        
        register { LogInUseCaseImpl(authenticationRepository: resolve()) as LogInUseCase }
        
        register { LogOutUseCaseImpl(authenticationRepository: resolve()) as LogOutUseCase }
        
        register { IsUserLoggedInUseCaseImpl(authenticationRepository: resolve()) as IsUserLoggedInUseCase }
        
        register { ResetPasswordUseCaseImpl(authenticationRepository: resolve()) as ResetPasswordUseCase }
    }
}
