//
//  RealmTableViewCell.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 24.10.2020.
//

import UIKit

protocol RealmTableViewCellDelegate {
    func setComplite(task: RealmEntity)
    func setNote(task: RealmEntity, note: String)
}

class RealmTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    var delegate: RealmTableViewCellDelegate?
    
    var task: RealmEntity? {
        didSet {
            guard let task = task else { return }
            titleLabel.text = "Task \(task.title)"
            dateLabel.text = task.date.formattedISO8601
            taskTextField.text = task.note
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
    
    func hideTask() {
        taskTextField.isEnabled = false
        checkButton.backgroundColor = .systemGray
        backgroundColor = .systemGray6
        
    }
    
    func unhideTask() {
        taskTextField.isEnabled = true
        checkButton.backgroundColor = .systemBlue
        backgroundColor = .systemOrange
    }
    
    
    @IBAction func tabIsCompleted(_ sender: Any) {
        delegate?.setComplite(task: task!)
    }
    
    
    @IBAction func taskTab(_ sender: Any) {
        guard let note = taskTextField.text else { return }
        delegate?.setNote(task: task!, note: note)
    }
}

extension Date {
    static let formatterISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var formattedISO8601: String {
        return Date.formatterISO8601.string(from: self)
    }
}
