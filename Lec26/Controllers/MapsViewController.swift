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
    var landmarks: [Landmark] = []{
        didSet{
            //add annotations:
            mapView.addAnnotations(landmarks.map(LandmarkAnnotation.init))
        }
    }
    
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
        
        mapView.delegate = self
    }
    
    
}

extension MapsViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let landmarkAnnotation = annotation as? LandmarkAnnotation else {return nil}
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: "Landmark") as? MKMarkerAnnotationView
        
        if av == nil{
            av = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Landmark")
        }
        av?.markerTintColor = landmarkAnnotation.landmark.color
        
        return av
    }
}


// github token:

// the new password for github push -u origin main is the token for this app
// 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
