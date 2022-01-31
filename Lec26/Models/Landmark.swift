//
//  Landmark.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 29/01/2022.
//


import UIKit
import CoreLocation


struct Landmark: Codable{
    let address: String
    let id: Int
    let illumination: String
    let name:String
    let powerOutlet: String
    let productURL:String
    let region:String
    let shortDescription:String
    let showers: String
    let specialActivity: String
    let staffRooms:String
    let trailerPark:String
    let url: String
    let vendorID:Int
    let vendorName: String
    let WC: String
    let x: Double
    let y: Double
    
}


extension Landmark{
    var coordinate: CLLocationCoordinate2D{
        .init(latitude: y, longitude: x)
    }
    
    var location: CLLocation{
         CLLocation(latitude: y, longitude: x)
    }
   
    var type: Types{
        Types.type(for: self.name)
    }
   
    var color: UIColor{
        switch self.type{
        case .campSchool:
            return .blue
        case .nationalPark:
            return .orange
        case .han:
            return .black
        case .nightCamp:
            return .systemMint
        case .other:
            return .red
        }
    }
}



enum Types: String, CaseIterable{
    case han = "חאן"
    case campSchool = "מרכז שדה"
    case nationalPark = "גן לאומי"
    case nightCamp = "חניון לילה"
    case other = "קמפינג"
    
    static func type(for name:String)-> Types{
        for t in Types.allCases{
            if name.contains(t.rawValue){
                return t
            }
        }
        return .other
    }
}
