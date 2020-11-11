//
//  ResetPasswordViewController.swift
//  TravelApplication
//
//  Created by User on 9/2/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    //MARK: -Outlets
    @IBOutlet weak var resetPassword: UIButton!
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPassword.layer.cornerRadius = 4
        
    }
    //MARK: -Actions
    @IBAction func ressetPassButton(_ sender: Any) {
            navigationController?.popViewController(animated: true)
    }

}
