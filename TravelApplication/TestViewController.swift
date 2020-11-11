//
//  testViewController.swift
//  TravelApplication
//
//  Created by mnem on 10/22/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAuth

class TestViewController: UIViewController {

    @IBOutlet weak var testViewLabel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { [weak self](status, error) in
            DispatchQueue.main.async { [weak self] in
                if let user = Auth.auth().currentUser?.uid {
                    self?.showTravelList()
                } else {
                    self?.showWelcomeScreen()
                }
            }
        }
    }
    func showWelcomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let stopVC = storyboard.instantiateViewController(identifier: "WelcomeViewController") as! WelcomeViewController
        self.navigationController?.pushViewController(stopVC, animated: false)
    }
    func showTravelList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let stopVC = storyboard.instantiateViewController(identifier: "TravelListViewController") as! TravelListViewController
        self.navigationController?.pushViewController(stopVC, animated: false)

}
}
