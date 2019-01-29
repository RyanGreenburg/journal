//
//  JournalController.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation

class JournalController {
    
    // Shared Instance
    static let shared = JournalController()
    
    // Source of truth
    var journals: [Journal] = []
    
    //MARK: - CRUD
    // CREATE
    func createJournalWith(name: String) {
        
        let journal = Journal(name: name)
        journals.append(journal)
        saveToPersistentStore()
    }
    
    // DELETE
    func delete(journal: Journal) {
        
        guard let index = journals.index(of: journal) else { return }
        journals.remove(at: index)
        saveToPersistentStore()
    }
    
    //MARK: - Persistence
    func fileURL() -> URL {
        // Establish path to file
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // File path to app
        let documentDirectory = paths[0]
        // Name of save file for app
        let fileName = "journal.json"
        // Creates save file for app
        let url = documentDirectory.appendingPathComponent(fileName)
        
        return url
    }
    
    func saveToPersistentStore() {
        
        let jsonEncoder = JSONEncoder()
        
        do {
            // Encode data to be saved
            let journalsAsData = try jsonEncoder.encode(JournalController.shared.journals)
            // Save data to user drive
            try journalsAsData.write(to: fileURL())
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadToPersistentStore() {
        
        let jsonDecoder = JSONDecoder()
        
        do {
            //Get data from save
            let data = try Data(contentsOf: fileURL())
            // Decode data into Playlist instance
            let decodedJournals = try jsonDecoder.decode([Journal].self, from: data)
            // Set new source of truth
            self.journals = decodedJournals
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
