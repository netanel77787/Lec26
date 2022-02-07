//
//  CampTableViewCell.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 04/02/2022.
//
import UIKit

class CampTableViewCell: UITableViewCell {
    @IBOutlet weak var roundLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    func populate(landmark: Landmark){
        roundLabel.text = landmark.type.rawValue
        nameLabel.text = landmark.name
        detailsLabel.text = landmark.vendorName
        //round:
        roundLabel.layer.cornerRadius = roundLabel.frame.height / 2
        roundLabel.layer.masksToBounds = true
        roundLabel.backgroundColor = landmark.color
        roundLabel.textColor = .white
        
    }
    
}
