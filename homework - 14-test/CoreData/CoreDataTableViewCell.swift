//
//  CoreDataTableViewCell.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 22.10.2020.
//

import UIKit

protocol CoreDataTableViewCellDelegate {
    func setComplite(task: Tasks)
    func setNote(task: Tasks, note: String)
}

class CoreDataTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var noteTextField: UITextField!
    
    var delegate: CoreDataTableViewCellDelegate?
    var task: Tasks? {
        didSet {
            guard let task = task else { return }
            titleLabel.text = "Task \(task.title)"
            dateLabel.text = task.date?.formattedISO8601
            noteTextField.text = task.note
            if task.isCompleted {
                hideTask()
            } else {
                unhideTask()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkButton.layer.cornerRadius = checkButton.frame.width / 2
    }
    
    @IBAction func setIsCompletedTask(_ sender: UIButton) {
        delegate?.setComplite(task: task!)
    }
    
    @IBAction func setNoteTask(_ sender: Any) {
        guard let note = noteTextField.text else { return }
        delegate?.setNote(task: task!, note: note)
    }
    
    func hideTask() {
        noteTextField.isEnabled = false
        checkButton.backgroundColor = .systemGray
        backgroundColor = .systemGray6
    }
    
    func unhideTask() {
        noteTextField.isEnabled = true
        checkButton.backgroundColor = .systemBlue
        backgroundColor = .systemYellow
    }
    
}
