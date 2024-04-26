//
//  UseCases+Resolver.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.03.2024.
//

import Resolver

public extension Resolver {
    static func registerUseCases() {
        
        // LocalNotifications
        register { RequestLocalNotificationAuthorizationUseCaseImpl() as RequestLocalNotificationAuthorizationUseCase }
        
        register {
            CheckLocalNotificationAuthorizationUseCaseImpl(requestLocalNotificationAuthorizationUseCase: resolve())
            as CheckLocalNotificationAuthorizationUseCase
        }
        
        register { ScheduleLocalNotificationUseCaseImpl() as ScheduleLocalNotificationUseCase }
        
        register { CancelLocalNotificationUseCaseImpl() as CancelLocalNotificationUseCase }
        
        // TimeFormatter
        register { FormatSecondsToStringUseCaseImpl() as FormatSecondsToStringUseCase }
        
        // Onboarding
        register { SaveHasUserSeenOnboardingUseCaseImpl(onboardingRepository: resolve()) as SaveHasUserSeenOnboardingUseCase }
        
        register { CheckHasUserSeenOnboardingUseCaseImpl(onboardingRepository: resolve()) as CheckHasUserSeenOnboardingUseCase }
        
        // Authentication
        register { SendEmailVerificationUseCaseImpl(authenticationRepository: resolve()) as SendEmailVerificationUseCase }
        
        register { SignUpUseCaseImpl(authenticationRepository: resolve(), sendEmailVerificationUseCase: resolve()) as SignUpUseCase }
        
        register { LogInUseCaseImpl(authenticationRepository: resolve()) as LogInUseCase }
        
        register { LogOutUseCaseImpl(authenticationRepository: resolve()) as LogOutUseCase }
        
        register { IsUserLoggedInUseCaseImpl(authenticationRepository: resolve()) as IsUserLoggedInUseCase }
        
        register { ResetPasswordUseCaseImpl(authenticationRepository: resolve()) as ResetPasswordUseCase }
        
        register { ChangePasswordUseCaseImpl(authenticationRepository: resolve()) as ChangePasswordUseCase }
        
        // Validation
        register { ValidateUsernameUseCaseImpl() as ValidateUsernameUseCase }
        
        register { ValidateEmailUseCaseImpl() as ValidateEmailUseCase }
        
        register { ValidatePasswordUseCaseImpl() as ValidatePasswordUseCase }
        
        register { ValidateRepeatedPasswordImpl() as ValidateRepeatedPasswordUseCase }
        
        register { ValidateGuildNameUseCaseImpl() as ValidateGuildNameUseCase }
        
        // User
        register { GetCurrentUserUseCaseImpl(userRepository: resolve()) as GetCurrentUserUseCase }
        
        register { IncreaseUserScoreUseCaseImpl(userRepository: resolve(), getCurretUserUseCase: resolve()) as IncreaseUserScoreUseCase }
        
        register { RemoveGuildForCurrentUserUseCaseImpl(userRepository: resolve()) as RemoveGuildForCurrentUserUseCase }
        
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
        
        // Board
        register { LoadBoardUseCaseImpl(boardsRepository: resolve()) as LoadBoardUseCase }
        
        // Invitations
        register { SendGuildInvitationUseCaseImpl(invitationsRepository: resolve()) as SendGuildInvitationUseCase }
        
        register { LoadMyInvitationsUseCaseImpl(invitationsRepository: resolve()) as LoadMyInvitationsUseCase }
        
        register { AcceptGuildInvitationUseCaseImpl(invitationsRepository: resolve()) as AcceptGuildInvitationUseCase }
        
        register { DeclineGuildInvitationUseCaseImpl(invitationsRepository: resolve()) as DeclineGuildInvitationUseCase }
        
        register { DeleteAllInvitationsForGuildUseCaseImpl(invitationsRepository: resolve()) as DeleteAllInvitationsForGuildUseCase }
        
        // Guilds
        register { CreateGuildUseCaseImpl(guildsRepository: resolve()) as CreateGuildUseCase }
        
        register { LoadMyGuildsUseCaseImpl(guildsRepository: resolve()) as LoadMyGuildsUseCase }
        
        register { LoadGuildUseCaseImpl(guildsRepository: resolve()) as LoadGuildUseCase }
        
        register {
            DeleteGuildUseCaseImpl(
                guildsRepository: resolve(),
                removeGuildForCurrentUserUseCase: resolve(),
                deleteAllInvitationsForGuildUseCase: resolve()
            ) as DeleteGuildUseCase
        }
        
        register { UpdateGuildUseCaseImpl(guildsRepository: resolve()) as UpdateGuildUseCase }
        
        // Members
        register { RemoveGuildMemberUseCaseImpl(membersRepository: resolve()) as RemoveGuildMemberUseCase }
        
        register { IncreaseMemberScoreUseCaseImpl(membersRepository: resolve()) as IncreaseMemberScoreUseCase }
        
        // Settings
        register { ChangeLanguageSettingsUseCaseImpl(settingsRepository: resolve()) as ChangeLanguageSettingsUseCase }
        
        register { ChangeNotificationsSettingsUseCaseImpl(settingsRepository: resolve()) as ChangeNotificationsSettingsUseCase }
        
        register { GetFullLanguageNameForIdentifierUseCaseImpl() as GetFullLanguageNameForIdentifierUseCase }
    }
}
