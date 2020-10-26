//
//  RealmTableViewController.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 20.10.2020.
//

import UIKit
import RealmSwift

class RealmTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addTask(_ sender: UIBarButtonItem) {
        let newTask = RealmEntity()
        newTask.title = (RealmPersistence.shared.tasks.last?.title ?? 0) + 1
        RealmPersistence.shared.addTask(task: newTask)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RealmPersistence.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RealmCell", for: indexPath) as! RealmTableViewCell

        cell.task = RealmPersistence.shared.tasks[indexPath.row]
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toDrop = RealmPersistence.shared.tasks[indexPath.row]
            RealmPersistence.shared.deleteTask(task: toDrop)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.isDecelerating {
            view.endEditing(true)
        }
    }
}

extension RealmTableViewController: RealmTableViewCellDelegate {
    func setComplite(task: RealmEntity) {
        RealmPersistence.shared.compitTask(task: task)
        tableView.reloadData()
    }
    
    func setNote(task: RealmEntity, note: String) {
        RealmPersistence.shared.noteTask(task: task, note: note)
        tableView.reloadData()
    }
    
    
}
