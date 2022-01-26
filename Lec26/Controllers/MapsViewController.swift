//
//  MapsViewController.swift
//  Lec26
//
//  Created by נתנאל מנצור on 26/01/2022.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!


    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            fatalError("No such segment")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
