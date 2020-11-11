//
//  StopListViewController.swift
//  TravelApplication
//
//  Created by  User on 9/6/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateStopViewControllerDelegate {
    
    func didCreate(stop: Stop) {
        travel?.stops.append(stop)
//        nameStopLabel.text = stop.name
//        discriptionLabel.text = stop.description
//        spentMoneyLabel.text = String(stop.spentMoney)
        stopTableView.reloadData()
        
    }
    
  
    //MARK: -Outlets
    
    @IBOutlet weak var transportLabel: UIImageView!
    @IBOutlet weak var spentMoneyLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var nameStopLabel: UILabel!
    @IBOutlet weak var stopTableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!

    //MARK: -Properties
    
    var travel: Travel?
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopTableView.delegate = self
        stopTableView.dataSource = self
        addBarButton.tintColor = #colorLiteral(red: 0.5137254902, green: 0.537254902, blue: 0.9098039216, alpha: 1)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopTableView.reloadData()
    }
    
    //MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel?.stops.count ?? 0
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 138
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! StopCell
        
        if let stop = travel?.stops[indexPath.row] {
            
            let stars = cell.stars!
            for index in 0...3 {
                stars[index].isHighlighted = true
            }
            
            
            cell.nameLebel.text = stop.name
            cell.descriptionLabel.text = stop.description
            cell.spentCurrencyLabel.text = "\(Int(stop.spentMoney))" + stop.currency.rawValue
            
            switch stop.transport {
            case .none:
                cell.transportImageView.image = #imageLiteral(resourceName: "Three")
            case .car:
                cell.transportImageView.image = #imageLiteral(resourceName: "Three")
            case .airplan:
                cell.transportImageView.image = #imageLiteral(resourceName: "One")
            case .train:
                cell.transportImageView.image  = #imageLiteral(resourceName: "Two")
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let createVC = storyboard.instantiateViewController(identifier: "CreateStopViewController") as! CreateStopViewController
        createVC.delegate = self
        createVC.travelId = travel?.id ?? ""
        createVC.stop = travel?.stops[indexPath.row]
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let stop = travel?.stops[indexPath.row] {
                removeStopFromServer(stop: stop)
            }
            tableView.beginUpdates()
            travel?.stops.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    
    //MARK: - Actions
    
    @IBAction func addStop(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(identifier: "CreateStopViewController") as! CreateStopViewController
        addVC.delegate = self
        addVC.travelId = travel?.id ?? ""
        navigationController?.pushViewController(addVC, animated: true)

    }
    
    func removeStopFromServer(stop: Stop) {
        let database = Database.database().reference()
        let child = database.child("stops").child("\(stop.id)")
        child.removeValue()
    }

}

