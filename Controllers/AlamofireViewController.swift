//
//  AlamofireViewController.swift
//  TravelApplication
//
//  Created by User on 9/28/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://jsonplaceholder.typicode.com/users").responseJSON { (response) in
            self.textView.text = "\(response.value ?? "")"
        }
        AF.request("https://jsonplaceholder.typicode.com/posts", method: .post, parameters: ["login":"alex", "password":"12345678"]).responseJSON { (response) in
               self.textView.text = "\(response.value ?? "")"
       }
    }
}
