//
//  JournalTableViewController.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class JournalTableViewController: UITableViewController, UITextFieldDelegate {

    
    @IBOutlet weak var journalTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Journals"
    }
    
    //ADD VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func addButtonTapped(_ sender: Any) {
        resignFirstResponder()
        guard let journalName = journalTextField.text, journalName != "" else { return }
        JournalController.shared.createJournalWith(name: journalName)
        journalTextField.text = ""
        tableView.reloadData()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return JournalController.shared.journals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        
        cell.textLabel?.text = journal.name
        
        if journal.entries.count == 1 {
            cell.detailTextLabel?.text = "\(journal.entries.count) Entry"
        } else {
            cell.detailTextLabel?.text = "\(journal.entries.count) Entries"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = JournalController.shared.journals[indexPath.row]
            JournalController.shared.delete(journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryTVSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? EntryTableViewController {
                    let journalToSend = JournalController.shared.journals[indexPath.row]
                    destinationVC.journal = journalToSend
                }
            }
        }
    }
}
