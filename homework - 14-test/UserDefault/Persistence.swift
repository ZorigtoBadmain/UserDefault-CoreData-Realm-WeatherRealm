//
//  Persistence.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 19.10.2020.
//

import Foundation

class Persistance {
    static let shared = Persistance()
    
    private var kUserNameKey = "Persistance.kUserNameKey"
    private var kSurNameKey = "Persistance.kSurNameKey"
    
    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { UserDefaults.standard.string(forKey: kUserNameKey) }
    }
    
    var surName: String? {
        set { return UserDefaults.standard.set(newValue, forKey: kSurNameKey) }
        get { return UserDefaults.standard.string(forKey: kSurNameKey)}
    }
}
