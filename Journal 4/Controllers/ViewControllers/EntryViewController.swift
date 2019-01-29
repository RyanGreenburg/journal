//
//  EntryViewController.swift
//  Journal 4
//
//  Created by RYAN GREENBURG on 1/26/19.
//  Copyright © 2019 RYAN GREENBURG. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {

    var entry: Entry?
    var journal: Journal?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = "\(prettyDate(date: Date()))"
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let entry = entry else { return }
        titleTextField.text = entry.title
        bodyTextField.text = entry.body
        dateLabel.text = prettyDate(date: entry.timestamp)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text else {print("Error unwrapping title"); return }
        guard let body = bodyTextField.text else { print("Error unwrapping body"); return }
        guard let journal = journal else {print("Error unwrapping journal"); return }
        
        if let entry = entry {
            //Update
            EntryController.shared.updateEntry(entry: entry, journal: journal, title: title, body: body)
        } else {
            EntryController.shared.addEntry(title: title, body: body, journal: journal)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func prettyDate(date: Date) -> String {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        
        return df.string(from: date)
    }
}
