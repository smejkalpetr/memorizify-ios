//
//  FormatSecondsToStringUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import Foundation

protocol FormatSecondsToStringUseCase {
    func execute(seconds: TimeInterval) throws -> String
}

struct FormatSecondsToStringUseCaseImpl: FormatSecondsToStringUseCase {
    
    init() {}
    
    func execute(seconds: TimeInterval) throws -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        guard let formattedTimeString = formatter.string(from: seconds) else { throw TimeFormatterError.failedToFormat }
        return formattedTimeString
    }
}
