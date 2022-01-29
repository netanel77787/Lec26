//
//  MapsViewController.swift
//  Lec26
//
//  Created by נתנאל מנצור on 26/01/2022.
//

import UIKit
import MapKit
import Combine
class MapsViewController: UIViewController {
    
    var subscriptions: Set<AnyCancellable> = []
    var landmarks: [Landmark] = []
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
        Landmarks.load().sink { completion in
            print(completion)
        } receiveValue: {[weak self] landmarks in
            self?.landmarks = landmarks
            print(landmarks)
        }.store(in: &subscriptions)

    }


}


// github token:

// the new password for github push -u origin main is the token for this app
// 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
