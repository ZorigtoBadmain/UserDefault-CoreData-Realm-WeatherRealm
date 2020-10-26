//
//  CoreDataTableViewController.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 19.10.2020.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.keyboardDismissMode = .onDrag
    }
    
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {

        CoreDataPersistent.shared.addTask()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CoreDataPersistent.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreDataCell", for: indexPath) as! CoreDataTableViewCell
        
        cell.task = CoreDataPersistent.shared.tasks[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataPersistent.shared.dropTask(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.isDecelerating {
            view.endEditing(true)
        }
    }
}



extension CoreDataTableViewController: CoreDataTableViewCellDelegate {
    func setComplite(task: Tasks) {
        CoreDataPersistent.shared.completTask(task: task)
        tableView.reloadData()
    }
    
    func setNote(task: Tasks, note: String) {
        CoreDataPersistent.shared.noteTask(task: task, note: note)
        tableView.reloadData()
    }
}
