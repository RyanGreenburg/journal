//
//  EntryTableViewController.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    var journal: Journal?
    var entryDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let journalName = journal?.name else { return }
        title = journalName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return journal?.entries.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = journal?.entries[indexPath.row]
        if let date = entry?.timestamp {
            self.entryDate = prettyDate(date: date)
        }
        
        guard let entryDate = entryDate else { return UITableViewCell()}
        
        cell.textLabel?.text = entry?.title
        cell.detailTextLabel?.text = entryDate
        
        return cell
    }
    
    func prettyDate(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        
        return df.string(from: date)
    }
    
    // Delete Journal
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let entry = journal?.entries[indexPath.row], let journal = journal else { return }
            EntryController.shared.deleteEntry(entry: entry, journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEntrySegue" {
            let destinationVC = segue.destination as? EntryViewController
            guard let selectedRow = tableView.indexPathForSelectedRow?.row else { return }
            let entry = journal?.entries[selectedRow]
            destinationVC?.entry = entry
            destinationVC?.journal = journal
        } else {
            let destinationVC = segue.destination as? EntryViewController
            destinationVC?.journal = journal
        }
    }
}
