//
//  MapViewController.swift
//  TravelApplication
//
//  Created by User on 9/21/20.
//  Copyright © 2020 mnem. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: -Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: -Properties
    
    var closure: ((CGPoint) -> Void)?
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(sender:)))
        mapView.addGestureRecognizer(longTapGesture)
        
    }
    
    @objc func longTap(sender:UIGestureRecognizer) {
        if sender.state == .began {
            mapView.removeAnnotations(mapView.annotations)
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationOnMap
            mapView.addAnnotation(annotation)
            
            let point = CGPoint(x: locationOnMap.latitude.rounded(2), y: locationOnMap.longitude.rounded(2))
            closure?(point)
        }
        
    }
}

extension Double {
    func rounded(_ number: Int) -> Double {
        let divisor = pow(10.0, Double(number))
        return (self * divisor).rounded() / divisor
    }
}
 
