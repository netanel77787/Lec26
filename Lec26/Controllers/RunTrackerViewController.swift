//
//  RunTrackerViewController.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 02/02/2022.
//

import UIKit
import Combine
import MapKit
import CoreLocation

class RunTrackerViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: nil)
    
    let lm = LocationManager.shared
    var subscriptions: Set<AnyCancellable> = []
    
    @IBOutlet weak var mapView: MKMapView!


    @IBAction func startTracking(_ sender: UIButton) {
        mapView.showsUserLocation = true

        lm.startMonitoring()
    }
    @IBAction func stopTracking(_ sender: UIButton) {
        mapView.showsUserLocation = false

        lm.stopMonitoring()
        
        addOverlay()
    }
    
    func addOverlay(){
        var coords = lm.steps.map{
            $0.coordinate
        }
        
        let polyline = MKPolyline(coordinates: &coords, count: coords.count)
        
        polyline.title = "Beach run"
        
        mapView.addOverlay(polyline)
    }
    
    func setRegion(_ location: CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.publisher(for: .LocationUpdated,
                                                object: nil).sink {[weak self] notification in
           if let location = notification.userInfo?["location"] as? CLLocation{
               self?.addOverlay()
               self?.setRegion(location)
            }
        }.store(in: &subscriptions)
        // Do any additional setup after loading the view.
        
        mapView.delegate = self
        
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    
    
   

}
extension RunTrackerViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {return}

        searchController.isActive = false
        let coder = CLGeocoder()
        
        coder.geocodeAddressString(text) {[weak self] arr, err in
            for place in arr ?? []{
                print("")
                guard let location = place.location else {return}
                
                let annotation = Annotation(location.coordinate, title: place.name, subtitle: place.administrativeArea)
                self?.mapView.addAnnotation(annotation)
                self?.setRegion(location)
            }
        }

    }
}

extension RunTrackerViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else{return MKOverlayRenderer()}
        
        let polylineRenderer = MKPolylineRenderer(polyline: polyline)
        
        polylineRenderer.lineWidth = 5
        polylineRenderer.strokeColor = .orange
        
        return polylineRenderer
    }
}
