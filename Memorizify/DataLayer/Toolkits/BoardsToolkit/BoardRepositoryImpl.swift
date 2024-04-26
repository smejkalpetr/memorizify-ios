//
//  BoardsRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 15.04.2024.
//

import Firebase

struct BoardsRepositoryImpl: BoardsRepository {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func getBoard() async throws -> Board {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
        
        var boardRecords: [BoardRecord] = []
            
        // Reference to the user collection
        let usersCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_USERS)
    
        // Fetch all documents from the subcollection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: usersCollectionRef.path)
        let querySnapshot = try await usersCollectionRef.getDocuments()
        
        // Iterate through the documents
        for document in querySnapshot.documents {
            let user = try document.data(as: User.self)
            let boardRecord = BoardRecord(uid: user.uid, username: user.username, score: user.score, isLeader: user.uid == firUser.uid)
            boardRecords.append(boardRecord)
        }
        
        return Board(records: boardRecords)
    }
}
