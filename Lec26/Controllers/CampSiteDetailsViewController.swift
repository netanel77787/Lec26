//
//  CampSiteDetailsViewController.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 04/02/2022.
//

import UIKit
import SafariServices

class CampSiteDetailsViewController: UIViewController {

    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var landmark: Landmark?
    
    @IBAction func website(_ sender: UIButton) {
     
    // פתיחת אתר אינטרנט בעברית מה producturl + urlquery
        
        guard let webAddress = landmark?.productURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: webAddress) else {return}
        
        let sfvc = SFSafariViewController(url: url)
        
        navigationController?.pushViewController(sfvc, animated: true)
        
        // פתיחת אתר אינטרנט מה url של ה json
        
//        guard let webAddress = landmark?.url,
//              let url = URL(string: webAddress) else {return}
//
//        let sfvc = SFSafariViewController(url: url)
//
//        navigationController?.pushViewController(sfvc, animated: true)
    }
    
    @IBAction func navigate(_ sender: UIButton) {
        guard let landmark = landmark else {
            return
        }
        
        let lat = landmark.coordinate.latitude
        let lon = landmark.coordinate.longitude
        
        let str = String(format: "http://maps.apple.com/?daddr=%f,%f", lat, lon)
        
        guard let url = URL(string: str) else {return}
                
        UIApplication.shared.open(url, options: [:])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let landmark = landmark else {
            return
        }
        
        // all this wont work if sender = nil in CampSitesTableViewController
        logoLabel.text = landmark.type.rawValue
        logoLabel.backgroundColor = landmark.color
        logoLabel.textColor = .white

        
        nameLabel.text = landmark.name
        
    }
    
}
