//
//  RealmPersistence.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 20.10.2020.
//

import Foundation
import RealmSwift

class RealmPersistence {
    static var shared = RealmPersistence()
    
    private let realm = try! Realm()
    
    var tasks:[RealmEntity] {
        return realm.objects(RealmEntity.self).map { $0 }
    }
    
    func addTask(task: RealmEntity) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    func compitTask(task: RealmEntity) {
        try! realm.write {
            task.isCompleted = !task.isCompleted
        }
    }
    
    func noteTask(task: RealmEntity, note: String) {
        try! realm.write {
            task.note = note
        }
    }
    
    func deleteTask(task: RealmEntity) {
        try! realm.write {
            realm.delete(task)
        }
    }
}
