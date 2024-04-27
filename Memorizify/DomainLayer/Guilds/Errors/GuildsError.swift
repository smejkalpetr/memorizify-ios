//
//  GuildsError.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 16.04.2024.
//

/// Represents errors that can occur during guild operations.
enum GuildsError: Error {
    case notFound           // The requested guild was not found.
    case noRecordForUser    // No record found for the user in the guild.
    case failedToSaveScore  // Failed to save the score for the guild.
}
