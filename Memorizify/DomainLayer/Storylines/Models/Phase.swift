//
//  Phase.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 13.04.2024.
//

enum Phase {
    case study
    case `break`
    
    mutating func toggle() {
        switch self {
        case .study:
            self = .break
        case .break:
            self = .study
        }
    }
}
