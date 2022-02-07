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
    let lm = LocationManager.shared
    
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

        mapView.delegate = self

        // Do any additional setup after loading the view.
        Landmarks.load().sink { completion in
            print(completion)
        } receiveValue: {[weak self] landmarks in
            self?.mapView.showsUserLocation = true
            self?.landmarks = landmarks
            print(landmarks)
        }.store(in: &subscriptions)
        
        
        NotificationCenter.default.publisher(for: .LocationUpdated, object: nil).sink {[weak self] _ in
            self?.mapView.showsUserLocation = true
            
        }.store(in: &subscriptions)
    }
    
    
}

extension MapsViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let landmarkAnnotation = annotation as? LandmarkAnnotation else {return nil}
        var av = mapView.dequeueReusableAnnotationView(withIdentifier: "Landmark") as? MKMarkerAnnotationView

        if av == nil{
            av = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "Landmark")
        }
        
        av?.canShowCallout = true
        av?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        av?.markerTintColor = landmarkAnnotation.landmark.color

        return av
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? LandmarkAnnotation,
              let detailsVC = storyboard?.instantiateViewController(withIdentifier: "details") as? CampSiteDetailsViewController else {return}
        
        detailsVC.landmark = annotation.landmark
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}


// github token:

// the new password for github push -u origin main is the token for this app
// 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
