//
//  WelcomeViewController.swift
//  TravelApplication
//
//  Created by User on 8/24/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig


class WelcomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAnAccount: UIButton!
    
    //MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad WelcomeViewController")
        roundCorners(button: loginButton, radius: 4)
        roundCorners(button: createAnAccount, radius: 4)
        let remoteConfig = RemoteConfig.remoteConfig()
        let loginText = remoteConfig["loginButtonText"].stringValue
        loginButton.setTitle(loginText, for: .normal)
        
        let isNeedToShowLoginButton = remoteConfig["isNeedToShowLoginButton"].boolValue
        if isNeedToShowLoginButton == false {
            loginButton.isHidden = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear WelcomeViewController")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear WelcomeViewController")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear WelcomeViewController")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisapear WelcomeViewController")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews WelcomeViewController")
    }
    //MARK: - Actions
    
    @IBAction func createAnAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registrationViewController = storyboard.instantiateViewController(identifier: "RegistrationViewController") as! RegistrationViewController
//        secondViewController.transferText = textField.text ?? ""
        navigationController?.pushViewController(registrationViewController, animated: true)
        
    }
    @IBAction func loginWithEmailButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
//        secondViewController.transferText = textField.text ?? ""
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    //MARK: - Functions
    func roundCorners(button: UIButton, radius: CGFloat) {
        button.layer.cornerRadius = radius
    }
}
