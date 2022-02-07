//
//  CampSitesTableViewController.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 04/02/2022.
//

import UIKit
import Combine
import CoreLocation

class CampSitesTableViewController: UITableViewController {

    var landmarks: [Landmark] = []
    
    var subscriptions: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Landmarks.load().receive(on: DispatchQueue.main).sink { _ in
            //done
        } receiveValue: {[weak self] landmarks in
            self?.landmarks = landmarks
            self?.tableView.reloadData()
        }.store(in: &subscriptions)

//        performSegue(withIdentifier: "details", sender: nil)
        NotificationCenter.default.publisher(for: .LocationUpdated, object: nil).sink {[weak self] _ in
            if let location = LocationManager.shared.location{
                self?.sortPlaces(by: location)
            }
        }.store(in: &subscriptions)


    }

    
    func sortPlaces(by location: CLLocation){
        landmarks.sort { landmark1, landmark2 in
            let distance1 = location.distance(from: landmark1.location)
            let distance2 = location.distance(from: landmark2.location)

            return distance1 < distance2
        }
        tableView.reloadData()
    }
  
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return landmarks.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? CampTableViewCell {
            cell.populate(landmark: landmarks[indexPath.row])
        }
        
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let landmark = landmarks[indexPath.row]
        
        
        // if u put sender nil all CampSiteDetailsViewController props for the labels wont work 
        performSegue(withIdentifier: "details", sender: landmark)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? CampSiteDetailsViewController,
              let landmark = sender as? Landmark else {return}
        
        dest.landmark = landmark
    }

}
