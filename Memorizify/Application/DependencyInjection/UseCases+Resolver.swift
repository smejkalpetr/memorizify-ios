//
//  UseCases+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Resolver

public extension Resolver {
    static func registerUseCases() {
        
        // Notifications
        register { RequestLocalNotificationAuthorizationUseCaseImpl() as RequestLocalNotificationAuthorizationUseCase }
        
        register { ScheduleLocalNotificationUseCaseImpl() as ScheduleLocalNotificationUseCase }
        
        register {
            CheckLocalNotificationAuthorizationUseCaseImpl(requestLocalNotificationAuthorizationUseCase: resolve())
            as CheckLocalNotificationAuthorizationUseCase
        }
        
        // TimeFormatter
        register { FormatSecondsToStringUseCaseImpl() as FormatSecondsToStringUseCase }
        
        // Onboarding
        register { SaveHasUserSeenOnboardingUseCaseImpl(onboardingRepository: resolve()) as SaveHasUserSeenOnboardingUseCase }
        
        register { CheckHasUserSeenOnboardingUseCaseImpl(onboardingRepository: resolve()) as CheckHasUserSeenOnboardingUseCase }
        
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
        
        // User
        register { GetCurrentUserUseCaseImpl(userRepository: resolve()) as GetCurrentUserUseCase }
        
        register { IncreaseUserScoreUseCaseImpl(userRepository: resolve(), getCurretUserUseCase: resolve()) as IncreaseUserScoreUseCase }
        
        // PomodoroTimer
        register { CreatePomodoroTimerUseCaseImpl() as CreatePomodoroTimerUseCase }
        
        register { SetPomodoroTimerDelegateUseCaseImpl() as SetPomodoroTimerDelegateUseCase }
        
        // Storylines
        register { SaveStorylineUseCaseImpl(storylinesRepository: resolve()) as SaveStorylineUseCase }
        
        register { LoadAllStorylinesUseCaseImpl(storylinesRepository: resolve()) as LoadAllStorylinesUseCase }
        
        register { DeleteStorylineUseCaseImpl(storylinesRepository: resolve()) as DeleteStorylineUseCase }
        
        register { GetCurrentStorylinePageUseCaseImpl() as GetCurrentStorylinePageUseCase }
        
        register { StartStorylineUseCaseImpl(
            createPomodoroTimerUseCase: resolve(),
            getCurrentStorylinePageUseCase: resolve()
        ) as StartStorylineUseCase }
    }
}
