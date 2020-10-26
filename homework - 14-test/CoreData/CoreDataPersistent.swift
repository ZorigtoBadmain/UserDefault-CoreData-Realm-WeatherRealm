//
//  CoreDataPersistent.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 22.10.2020.
//

import UIKit
import CoreData

class CoreDataPersistent {
    static var shared = CoreDataPersistent()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private lazy var managedContext = self.appDelegate.persistentContainer.viewContext
    private lazy var entity = NSEntityDescription.entity(forEntityName: "Tasks", in: self.managedContext)!
    
    lazy var tasks: [Tasks] = try! self.managedContext.fetch(NSFetchRequest<Tasks>(entityName: "Tasks"))
    
    func addTask() {
        let task = Tasks(entity: entity, insertInto: managedContext)
        let taskNumber = (tasks.last?.title ?? 0) + 1
        task.setValue(taskNumber, forKeyPath: "title")
        task.setValue(Date(), forKey: "date")
        
        do {
            try managedContext.save()
            tasks.append(task)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func completTask(task: Tasks) {
        task.setValue(!task.isCompleted, forKeyPath: "isCompleted")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
        }
    }
    
    func noteTask(task: Tasks, note: String) {
        task.setValue(note, forKeyPath: "note")
        do {
            try managedContext.save()
        } catch let error as NSError{
            print("\(error), \(error.userInfo)")
        }
    }
    
    func dropTask(index: Int) {
        let task = tasks.remove(at: index)
        do {
            try managedContext.save()
            managedContext.delete(task)
        } catch let error as NSError{
            print("\(error), \(error.userInfo)")
        }
    }
}

