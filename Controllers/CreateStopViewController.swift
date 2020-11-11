//
//  CreateStopViewController.swift
//  TravelApplication
//
//  Created by User on 8/6/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase

protocol CreateStopViewControllerDelegate {
    func didCreate(stop: Stop)
}


class CreateStopViewController: UIViewController, SpentMoneyViewControllerDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var nameStopTextField: UITextField!
    @IBOutlet weak var viewStepper: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var spentMoneyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //MARK: - Properties
    var delegate: CreateStopViewControllerDelegate?
    var stop: Stop?
    var travelId: String = ""
    var locationSelected: CGPoint = .zero
    var selectedMoney: Double = 0
    var selectedCurrency: Currency = .none
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStepper.layer.borderWidth = 1
        viewStepper.layer.cornerRadius = 4
        viewStepper.layer.borderColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        textView.contentInset.left = 16
        textView.contentInset.right = 16
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        saveButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        if let stop = stop {
            nameStopTextField.text = stop.name
            textView.text = stop.description
            ratingLabel.text = String(stop.rating)
            pointLabel.text = "\(stop.location.x)-\(stop.location.y)"
            locationSelected = stop.location
            selectedMoney = stop.spentMoney
            selectedCurrency = stop.currency
            spentMoneyLabel.text = "\(stop.spentMoney) \(stop.currency.rawValue)"
            switch stop.transport {
            case .none:
                break
            case .car:
                segmentedControl.selectedSegmentIndex = 2
            case .airplan:
                segmentedControl.selectedSegmentIndex = 1
            case .train:
                segmentedControl.selectedSegmentIndex = 0
            }
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Actions
    
    @IBAction func spentMoneyClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let spentVC = storyboard.instantiateViewController(identifier: "SpentMoneyViewController") as! SpentMoneyViewController
        spentVC.delegate = self
        present(spentVC, animated: true, completion: nil)
    }
    
    func spent(money: Double, currency: Currency) {
        spentMoneyLabel.text = String(money) + " " + currency.rawValue
        selectedMoney = money
        selectedCurrency = currency
    }
    
    @IBAction func addPointOnMap(_ sender: Any) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mapVC = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        let mapVC = MapViewController.fromStoryboard() as! MapViewController
        navigationController?.pushViewController(mapVC, animated: true)
        
        mapVC.closure = { point in //point - любое название параметра
            self.pointLabel.text = "\(point.x) - \(point.y)"
            self.locationSelected = point
        }
    }
    
    @IBAction func plusRating(_ sender: Any) {
        if let text = ratingLabel.text, let currentValue = Int(text) {
            ratingLabel.text = String(currentValue + 1)
            if currentValue >= 5 {
                ratingLabel.text = String(5)
            }
        }
        
    }
    @IBAction func minusRating(_ sender: Any) {
        if let text = ratingLabel.text, let currentValue = Int(text) {
            ratingLabel.text = String(currentValue - 1)
            if currentValue <= 0 {
                ratingLabel.text = String(0)
            }
        }
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        if let stop = stop {
            update(stop: stop)
            sendToServer(stop: stop)
        } else {
            let id = UUID().uuidString
            let stop = Stop(id: id, travelId: travelId)
            update(stop: stop)
            delegate?.didCreate(stop: stop)
            sendToServer(stop: stop)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func update(stop: Stop) {
        stop.name = nameStopTextField.text ?? ""
        stop.location = locationSelected
        stop.spentMoney = selectedMoney
        stop.currency = selectedCurrency
        stop.rating = Int(ratingLabel.text ?? "") ?? 0
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            stop.transport = .train
        case 1:
            stop.transport = .airplan
        case 2:
            stop.transport = .car
        default:
            break
        }
        stop.description = textView.text ?? ""
        
    }
    
    
    func sendToServer(stop: Stop) {
        let database = Database.database().reference()
        let child = database.child("stops").child("\(stop.id)")
        child.setValue(stop.json) { [weak self](error, ref) in
        print(error, ref)
        }
    }
    
}
