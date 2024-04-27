//
//  MembersRepositoryImpl.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 17.04.2024.
//

/// Implementation of the MembersRepository protocol.
struct MembersRepositoryImpl: MembersRepository {
    
    private let guildsRepository: GuildsRepository
    private let userRepository: UserRepository
    
    /// Initializes a new instance of MembersRepositoryImpl.
    /// - Parameters:
    ///   - guildsRepository: The repository for guild-related operations.
    ///   - userRepository: The repository for user-related operations.
    init(guildsRepository: GuildsRepository, userRepository: UserRepository) {
        self.guildsRepository = guildsRepository
        self.userRepository = userRepository
    }
    
    /// Removes a member from a guild asynchronously.
    /// - Parameters:
    ///   - uid: The UID of the member to remove.
    ///   - guild: The guild from which to remove the member.
    func remove(with uid: String, from guild: Guild) async throws {
        // Refresh guild before request because somebody could have changed it meanwhile
        let refreshedGuild = try await guildsRepository.load(guild)
        
        // Remove the user from the guild board and update it
        var newBoard = refreshedGuild.board
        newBoard.records.removeAll { $0.uid == uid }
        
        let newGuild = Guild(copy: refreshedGuild, board: newBoard)
        try await guildsRepository.update(newGuild)
        
        // Remove the guild from the User entity
        let user = try await userRepository.getUser(uid: uid)
        
        var newGuildIds = user.guildIds
        newGuildIds?.removeAll { $0 == refreshedGuild.id }
        
        
        let newUser = User(copy: user, guildIds: newGuildIds)
        try await userRepository.update(user: newUser)
    }
    
    /// Updates the score of a member in a guild asynchronously.
    /// - Parameters:
    ///   - score: The new score of the member.
    ///   - guild: The guild in which to update the member's score.
    func updateScore(to score: Double, in guild: Guild) async throws {
        // Get User entity of current user
        let user = try await userRepository.getCurrentUser()
        
        // Refresh guild before request because somebody could have changed it meanwhile
        let refreshedGuild = try await guildsRepository.load(guild)
        
        // Update their score in the guild record
        guard var oldRecord = refreshedGuild.board.records.first(where: { $0.uid == user.uid }) else { throw GuildsError.noRecordForUser }
        let newRecord = BoardRecord(copy: oldRecord, score: oldRecord.score + score)
        
        var allRecords = refreshedGuild.board.records
        allRecords.removeAll { $0.uid == user.uid }
        allRecords.append(newRecord)
        
        let newBoard = Board(records: allRecords)
        let newGuild = Guild(copy: refreshedGuild, board: newBoard)
        
        try await guildsRepository.update(newGuild)
    }
}
