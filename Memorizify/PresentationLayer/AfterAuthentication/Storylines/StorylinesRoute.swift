//
//  StorylinesRoute.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 24.03.2024.
//

import Foundation

enum StorylinesRoute {
    case showDetail(StorylineKind)
}

extension StorylinesRoute: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .showDetail(kind):
            hasher.combine(kind.id)
            hasher.combine(kind.rawValue)
        }
    }
    
    static func == (lhs: StorylinesRoute, rhs: StorylinesRoute) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
