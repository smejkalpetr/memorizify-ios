//
//  MemorizifyLogger.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 26.04.2024.
//

import Foundation

struct MemorizifyLogger {
    static func log(file: String, line: String, description: String) {
        NSLog("🆕 \(file), line \(line): \(description)")
    }
    
    static func logDocumentsUpdate(file: String, line: Int, documentPath: String, data: [String: Any], description: String? = nil) {
        NSLog("➡️ \(file), line \(line): Updating document(s):")
        NSLog("    Document(s): \(documentPath)")
        NSLog("    Data: \(data)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
    
    static func logDocumentsFetch(file: String, line: Int, documentPath: String, description: String? = nil) {
        NSLog("⬅️ \(file), line \(line): Fetching document(s):")
        NSLog("    Document(s): \(documentPath)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
    
    static func logDocumentsDelete(file: String, line: Int, documentPath: String, description: String? = nil) {
        NSLog("⬇️ \(file), line \(line): Deleting document(s):")
        NSLog("    Document(s): \(documentPath)")
        if let description {
            NSLog("    Description: \(description)")
        }
    }
}
