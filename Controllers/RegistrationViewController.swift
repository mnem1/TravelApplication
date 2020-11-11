//
//  RegistrationViewController.swift
//  TravelApplication
//
//  Created by mnem on 10/13/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationButton.layer.cornerRadius = 4
    }
    

    @IBAction func registrationClicked(_ sender: Any) {
        let email = "test1@gmail.com"
        let password = "123456"
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else {return}
            if let user = result?.user {
                print("User was created: \(user.email)")
            } else if let error = error {
                print("Create error: \(error)")
            }
        }
    }


}
