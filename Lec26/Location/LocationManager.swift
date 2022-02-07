//
//  LocationManager.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 31/01/2022.
//

import CoreLocation


class LocationManager:NSObject{
    //props:
    private let clm = CLLocationManager()
    //static props:
    static let shared = LocationManager()
    
    private (set) var isMonitoring = false
    private (set) var steps: [CLLocation] = []
    
    func startMonitoring(){
        if hasPermission{
            isMonitoring = true
            steps.removeAll()
            clm.startUpdatingLocation()
        }
    }
    
    func stopMonitoring(){
            isMonitoring = false
            clm.stopUpdatingLocation()
       
    }
    
    private override init(){
        //delegate: permission? location changed? heading changed
        super.init()
        setup()
    }
    
    
    var location: CLLocation?{
        clm.location
    }
    
    func setup(){
        clm.delegate = self
        clm.activityType = .fitness
        clm.distanceFilter = 100
        clm.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    var hasPermission: Bool{
        let status = clm.authorizationStatus
        return status == .authorizedAlways || status == .authorizedWhenInUse
    }
    
}

extension LocationManager: CLLocationManagerDelegate{
    //runs first when the object is initialized
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        switch status  {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("we have permission")
           
            NotificationCenter.default.post(name: .WeHavePermission, object: nil)
        case .denied, .restricted:
            print("no permission")
            //go to settings
        default:
            print("unknown enum cases")
            break
            
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        steps += locations
        
        NotificationCenter.default.post(name: .StepsAdded, object: nil, userInfo: ["steps" : steps])
        NotificationCenter.default.post(name: .LocationUpdated, object: nil, userInfo: ["location" : locations[0]])
        
    }
    
}

extension Notification.Name{
    static let StepsAdded = Notification.Name("edu.netanelma.steps")
    static let WeHavePermission = Notification.Name("edu.netanelma.have.permission")
    static let LocationUpdated = Notification.Name("edu.netanelma.last.known.location")

}
