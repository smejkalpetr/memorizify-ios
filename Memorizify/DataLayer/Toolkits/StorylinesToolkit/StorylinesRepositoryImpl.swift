//
//  StorylinesRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 10.04.2024.
//

import Firebase
import FirebaseFirestore

/// Implementation of the StorylinesRepository protocol.
struct StorylinesRepositoryImpl: StorylinesRepository {
    
    private let authenticationRepository: AuthenticationRepository
    
    /// Initializes a new instance of StorylinesRepositoryImpl.
    /// - Parameter authenticationRepository: The repository for authentication operations.
    init(authenticationRepository: AuthenticationRepository) {
        self.authenticationRepository = authenticationRepository
    }
    
    /// Loads all storylines associated with the current user asynchronously.
    /// - Returns: An array of Storyline objects, or nil if no storylines are found.
    func loadAll() async throws -> [Storyline]? {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
        
        var storylines: [Storyline] = []
            
        // Reference to the user's storylines subcollection
        let storylinesCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                                        .document(firUser.uid)
                                        .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
    
        // Fetch all documents from the subcollection
        MemorizifyLogger.logDocumentsFetch(file: #file, line: #line, documentPath: storylinesCollectionRef.path)
        let querySnapshot = try await storylinesCollectionRef.getDocuments()
        
        // Iterate through the documents and decode them into Storyline objects
        for document in querySnapshot.documents {
            let storyline = try document.data(as: Storyline.self)
            storylines.append(storyline)
        }
        
        return storylines.isEmpty ? nil : storylines
    }
    
    /// Updates the specified storyline asynchronously.
    /// - Parameter storyline: The storyline to update.
    func update(_ storyline: Storyline) async throws {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
                
        // Encode Storyline using the Firestore encoder
        let storylineDict = try Firestore.Encoder().encode(storyline)
        
        // Add Storyline to the user's storylines collection as a document
        let documentRef = db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                            .document(firUser.uid)
                            .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
                            .document(storyline.id)
        
        MemorizifyLogger.logDocumentsUpdate(file: #file, line: #line, documentPath: documentRef.path, data: storylineDict)
        try await documentRef.setData(storylineDict)
    }
    
    /// Deletes the specified storyline asynchronously.
    /// - Parameter storyline: The storyline to delete.
    func delete(_ storyline: Storyline) async throws {
        let db = Firestore.firestore()
        
        let firUser = try authenticationRepository.getUser()
        
        // Delete Storyline from the user's storylines collection
        let documentRef = db.collection(Constants.FIREBASE_COLLECTION_STORYLINES)
                            .document(firUser.uid)
                            .collection(Constants.FIREBASE_COLLECTION_USER_STORYLINES)
                            .document(storyline.id)
        
        MemorizifyLogger.logDocumentsDelete(file: #file, line: #line, documentPath: documentRef.path)
        try await documentRef.delete()
    }
    
    /// Deletes all storylines associated with the specified user UID asynchronously.
    /// - Parameter userUid: The UID of the user whose storylines will be deleted.
    func deleteAll(of userUid: String) async throws {
        let db = Firestore.firestore()
            
        // Reference to the user's storylines subcollection
        let storylinesCollectionRef = db.collection(Constants.FIREBASE_COLLECTION_STORYLINES).document(userUid)
    
        // Delete the collection
        MemorizifyLogger.logDocumentsDelete(file: #file, line: #line, documentPath: storylinesCollectionRef.path)
        try await storylinesCollectionRef.delete()
    }
}
