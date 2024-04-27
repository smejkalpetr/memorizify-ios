//
//  FormatSecondsToStringUseCase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

import Foundation

/// Converts seconds to a formatted string representation.
protocol FormatSecondsToStringUseCase {
    
    /// Executes the conversion of seconds to a formatted string.
    /// - Parameter seconds: The number of seconds to convert.
    /// - Returns: The formatted string representation of the given seconds.
    func execute(seconds: TimeInterval) throws -> String
}

/// Implementation of the FormatSecondsToStringUseCase protocol.
struct FormatSecondsToStringUseCaseImpl: FormatSecondsToStringUseCase {
    
    /// Initializes the FormatSecondsToStringUseCaseImpl instance.
    init() {}
    
    /// Executes the conversion of seconds to a formatted string.
    /// - Parameter seconds: The number of seconds to convert.
    /// - Returns: The formatted string representation of the given seconds.
    func execute(seconds: TimeInterval) throws -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        
        guard let formattedTimeString = formatter.string(from: seconds) else { throw TimeFormatterError.failedToFormat }
        return formattedTimeString
    }
}
