//
//  MemorizifyLogger.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 26.04.2024.
//

import Foundation

/// Logging utility for Memorizify application.
struct MemorizifyLogger {
    static func log(file: String, line: String, description: String) {
        NSLog("🆕 \(file), line \(line): \(description)")
    }
    
    /// Logs the update of documents in Firestore.
    /// - Parameters:
    ///   - file: The file name.
    ///   - line: The line number.
    ///   - documentPath: The path of the document being updated.
    ///   - data: The data being updated.
    ///   - description: Optional description of the update.
    static func logDocumentsUpdate(file: String, line: Int, documentPath: String, data: [String: Any], description: String? = nil) {
        NSLog("➡️ \(file), line \(line): Updating document(s):")
        NSLog("    Document(s): \(documentPath)")
        NSLog("    Data: \(data)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
    
    /// Logs the fetching of documents from Firestore.
    /// - Parameters:
    ///   - file: The file name.
    ///   - line: The line number.
    ///   - documentPath: The path of the document being fetched.
    ///   - description: Optional description of the fetch.
    static func logDocumentsFetch(file: String, line: Int, documentPath: String, description: String? = nil) {
        NSLog("⬅️ \(file), line \(line): Fetching document(s):")
        NSLog("    Document(s): \(documentPath)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
    
    /// Logs the deletion of documents from Firestore.
    /// - Parameters:
    ///   - file: The file name.
    ///   - line: The line number.
    ///   - documentPath: The path of the document being deleted.
    ///   - description: Optional description of the deletion.
    static func logDocumentsDelete(file: String, line: Int, documentPath: String, description: String? = nil) {
        NSLog("⬇️ \(file), line \(line): Deleting document(s):")
        NSLog("    Document(s): \(documentPath)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
}
