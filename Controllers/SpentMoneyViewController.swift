//
//  EnterAmountSpentViewController.swift
//  TravelApplication
//
//  Created by User on 9/2/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import RealmSwift


enum Currency: String, RealmEnum {
    case none = ""
    case ruble = "₽"
    case euro = "€"
    case dollar = "$"
}

protocol SpentMoneyViewControllerDelegate {
    func spent(money: Double, currency: Currency)
}

class SpentMoneyViewController: UIViewController {

    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var enterEmountTextField: UITextField!
    @IBOutlet weak var segmentMoney: UISegmentedControl!
    
    //MARK: - Properties
    var delegate: SpentMoneyViewControllerDelegate?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        enterEmountTextField.layer.cornerRadius = 6
        readyButton.layer.cornerRadius = 8
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Actions
    @IBAction func doneClicked(_ sender: Any) {
        if let text = enterEmountTextField.text, let money = Double(text) {
        
            var currency: Currency = .none
            switch segmentMoney.selectedSegmentIndex {
            case 0:
                currency = .dollar
            case 1:
                currency = .euro
            case 2:
                currency = .ruble
            default:
                break
            }
            delegate?.spent(money: money, currency: currency)
            dismiss(animated: true, completion: nil)
        }
       
    }

}
