//
//  ViewController.swift
//  homework - 14-test
//
//  Created by Зоригто Бадмаин on 19.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = Persistance.shared.userName
        surname.text = Persistance.shared.surName
    }

    @IBAction func saveUser(_ sender: UIButton) {
        Persistance.shared.userName = name.text
        Persistance.shared.surName = surname.text
    }
    
}

