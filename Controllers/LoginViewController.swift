//
//  LoginViewController.swift
//  TravelApplication
//
//  Created by User on 8/24/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    //срабатывает когда экран был загружен. верстки еще нет.
    //MARK: - Outlets
    
    @IBOutlet weak var loginWithEmail: UIButton!
    @IBOutlet weak var enterMailTextField: UITextField!
    @IBOutlet weak var enterPasswordTextField: UITextField!
    
    //MARK: - LiveCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad LoginViewController")
        loginWithEmail.layer.cornerRadius = 4
        enterMailTextField.delegate = self
        enterPasswordTextField.delegate = self
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear LoginViewController")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear LoginViewController")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear LoginViewController")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisapear LoginViewController")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews LoginViewController")
    }
    deinit {
        print("deinit")
    }
    //MARK: - Actions
    
    @IBAction func forgotPassButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let forgotPassViewController = storyboard.instantiateViewController(identifier: "ResetPasswordViewController") as! ResetPasswordViewController
        navigationController?.pushViewController(forgotPassViewController, animated: true)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        //        let email = "test1@gmail.com"
        //        let password = "123456"
        Auth.auth().signIn(withEmail: enterMailTextField.text ?? "", password: enterPasswordTextField.text ?? "") { [weak self](result, error) in
            guard let self = self else {return}
            if let user = result?.user {
                print("User was logined: \(user.email)")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = storyboard.instantiateViewController(identifier: "TravelListViewController") as! TravelListViewController
                self.navigationController?.pushViewController(loginViewController, animated: true)
            } else if let error = error {
                print("Login error: \(error)")
                self.enterMailTextField.textColor = .red
                self.enterPasswordTextField.textColor = .red
                if self.enterMailTextField.text?.isEmpty==true
                {
                    self.enterMailTextField.textColor = .black
                    self.enterMailTextField.layer.borderColor = UIColor.red.cgColor
                    self.enterMailTextField.layer.borderWidth = 1.0
                }
                else
                {
                    self.enterMailTextField.layer.borderWidth = 0.0
                }
                if self.enterPasswordTextField.text?.isEmpty==true
                {
                    self.enterPasswordTextField.textColor = .black
                    self.enterPasswordTextField.layer.borderColor = UIColor.red.cgColor
                    self.enterPasswordTextField.layer.borderWidth = 1.0
                }
                else
                {
                    self.enterPasswordTextField.layer.borderWidth = 0.0
                }
            }
        }
        
        
        
    }
    
    
    //MARK: - Functions
    
    @IBAction func enterPasswordTextFieldChaged(_ sender: Any) {
//        if ((enterPasswordTextField.text?.isEmpty) != nil) {
            self.enterPasswordTextField.textColor = .black
//        }
        
    }
    @IBAction func enterMaleTextfieldChanged(_ sender: Any) {
//        if ((enterMailTextField.text?.isEmpty) != nil) {
            self.enterMailTextField.textColor = .black
//        }
    }
}
