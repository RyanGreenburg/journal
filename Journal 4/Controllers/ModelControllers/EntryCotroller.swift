//
//  EntryCotroller.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import Foundation


class EntryController {
    
    static let shared = EntryController()
    
    // Create
    func addEntry(title: String, body: String, journal: Journal) {
        guard let indexOfEntry = JournalController.shared.journals.index(of: journal) else { return }
        
        let entry = Entry(title: title, body: body)
        JournalController.shared.journals[indexOfEntry].entries.append(entry)
        JournalController.shared.saveToPersistentStore()
    }
    
    //Update
    func updateEntry(entry: Entry, journal: Journal, title: String, body: String) {
        //Index of existing Journal
        guard let indexOfJournal = JournalController.shared.journals.index(of: journal) else { return }
        //Index of existing Entry
        guard let indexOfEntry = JournalController.shared.journals[indexOfJournal].entries.index(of: entry) else { return }
        
        //Replace entry with updated entry
        JournalController.shared.journals[indexOfJournal].entries[indexOfEntry].title = title
        JournalController.shared.journals[indexOfJournal].entries[indexOfEntry].body = body
        JournalController.shared.saveToPersistentStore()
    }
    
    //Delete
    func deleteEntry(entry: Entry, journal: Journal) {
        //Index of existing Jounal
        guard let indexOfJournal = JournalController.shared.journals.index(of: journal) else { return }
        //Spot of entry in the journals index
        guard let indexOfEntry = JournalController.shared.journals[indexOfJournal].entries.index(of: entry) else { return }
        
        //Remove the entry
        JournalController.shared.journals[indexOfJournal].entries.remove(at: indexOfEntry)
        JournalController.shared.saveToPersistentStore()
    }
}
