//
//  StorylinesRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

import Firebase
import FirebaseFirestore

struct StorylinesRepositoryImpl: StorylinesRepository {
    
    private let authenticationRepository: AuthenticationRepository
    
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    func loadAll() async throws -> [Storyline]? {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
        
        var storylines: [Storyline] = []
            
        // Reference to the user's storylines subcollection
        let storylinesCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                                        .document(firUser.uid)
                                        .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
    
        // Fetch all documents from the subcollection
        let querySnapshot = try await storylinesCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Storyline objects
        for document in querySnapshot.documents {
            let storyline = try document.data(as: Storyline.self)
            storylines.append(storyline)
        }
        
        return storylines.isEmpty ? nil : storylines
    }
    
    func update(_ storyline: Storyline) async throws {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
                
        // Encode Storyline using the Firestore encoder
        let storylineDict = try Firestore.Encoder().encode(storyline)
        
        // Add Storyline to the user's storylines collection as a document
        try await db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                    .document(firUser.uid)
                    .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
                    .document(storyline.id)
                    .setData(storylineDict)
    }
    
    func delete(_ storyline: Storyline) async throws {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
        
        // Delete Storyline from the user's storylines collection
        try await db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                    .document(firUser.uid)
                    .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
                    .document(storyline.id)
                    .delete()
    }
}
