//
//  TravelListViewController.swift
//  TravelApplication
//
//  Created by User on 8/27/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import RealmSwift

class TravelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!

    //MARK: - Properties
    
    var travels: [Travel] = []
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let travelObjects = DatabaseManager.shared.getObjects(classType: RLMTravel.self)
        let stopObjects = DatabaseManager.shared.getObjects(classType: RLMStop.self)
        tableView.delegate = self
        tableView.dataSource = self
        getTravelFromServer()
        getStopsFromServer()


        let resultJson = travels.map({ $0.json })
    }
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as! TravelCell
        let travel = travels[indexPath.row]
        cell.nameLabel.text = travel.name
        cell.descriptionLabel.text = travel.description
        for i in 0..<travel.avarageRate {
            cell.starsLabel[i].isHighlighted = true
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let stopVC = storyboard.instantiateViewController(identifier: "StopListViewController") as! StopListViewController
        stopVC.travel = travels[indexPath.row]
        navigationController?.pushViewController(stopVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeFromServer(travels[indexPath.row])
            tableView.beginUpdates()
            travels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    //MARK: -Actions
    
    @IBAction func addTravelButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add new Travel", message: "Enter name & description", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self](saveAction) in
            guard let self = self else {return}
            let firstTExtField = alertController.textFields?[0]
            let secondTExtField = alertController.textFields?[1]
            if let name = firstTExtField?.text, let desc = secondTExtField?.text {
                let id = UUID().uuidString
                if let userId = Auth.auth().currentUser?.uid {
                    let travel = Travel.init(userId: userId, id: id, name: name, description: desc)
                    self.sendToServer(travel: travel)
                    self.travels.append(travel)
                    self.tableView.reloadData()
                    DatabaseManager.shared.saveTravelInDatabase(travel)
                }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancelAction) in
        }
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter name"
        }
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter describe"
        }
        self.present(alertController, animated: true, completion: nil)
    }
    //MARK: - Function
    
    func getTravelFromServer() {
        let database = Database.database().reference()
        database.child("travels").observeSingleEvent(of: .value) {[weak self](snapshot) in
            guard let self = self else {return}
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            for item in value.values {
                if let travelJson = item as? [String: Any] {
                    if let id = travelJson["id"] as? String,
                       let name = travelJson["name"] as? String,
                       let description = travelJson["description"] as? String {
                        if let userId = Auth.auth().currentUser?.uid {
                            let travel = Travel(userId: userId, id: id, name: name, description: description)
                            self.travels.append(travel)
                            self.tableView.reloadData()
                        }
                    }
                    
                }
            }
            print(value.values)
        }
    }
//    "id": id,
//            "name": name,
//            "rating": rating,
//            "location": "\(location.x)-\(location.y)",
//            "transport": transport.rawValue,
//            "description": description,
//            "spentMoney": spentMoney,
//            "currency":
    func getStopsFromServer() {
        let database = Database.database().reference()
        database.child("stops").observeSingleEvent(of: .value) {[weak self](snapshot) in
            guard let self = self, let value = snapshot.value as? [String: Any] else {
                return
            }
            for item in value.values {
                if let stopJson = item as? [String: Any] {
                    if let id = stopJson["id"] as? String,
                       let travelId = stopJson["travelId"] as? String {
                        let stop = Stop(id: id, travelId: travelId)
                        if let name = stopJson["name"] as? String {
                            stop.name = name
                        }
                        if let description = stopJson["description"] as? String {
                            stop.description = description
                        }
                        if let locationString = stopJson["location"] as? String {
                            let components = locationString.components(separatedBy: "-")
                            let x = Double(components.first!)!
                            let y = Double(components.last!)!
                            stop.location = CGPoint(x: x, y: y)
                        }
                        if let transportInt = stopJson["transport"] as? Int {
                            stop.transport = Transport.init(rawValue: transportInt)!
                        }
                        if let rating = stopJson["rating"] as? Int {
                            stop.rating = rating
                        }
                        if let currencyString = stopJson["currency"] as? String,
                           let currency = Currency(rawValue: currencyString){
                            stop.currency = currency
                        }
                        if let spentMoney = stopJson["spentMoney"] as? Int {
                            stop.spentMoney = Double(spentMoney)
                        }
                        for travel in self.travels {
                            if travel.id == travelId {
                                travel.stops.append(stop)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func sendToServer(travel: Travel) {
        let database = Database.database().reference()
        let child = database.child("travels").child("\(travel.id)")
        child.setValue(travel.json) { [weak self](error, ref) in
            print(error, ref)
        }
    }
    
    func removeFromServer(_ travel: Travel) {
        let database = Database.database().reference()
        let child = database.child("travels").child("\(travel.id)")
        child.removeValue()
       
    }
    

}
