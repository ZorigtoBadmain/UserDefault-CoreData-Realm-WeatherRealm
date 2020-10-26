//
//  Item.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 20.10.2020.
//

import RealmSwift

class RealmEntity: Object {
    @objc dynamic var title = Int()
    @objc dynamic var date = Date()
    @objc dynamic var note = String()
    @objc dynamic var isCompleted = false
}
