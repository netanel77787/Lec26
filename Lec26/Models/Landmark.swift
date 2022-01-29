//
//  Landmark.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 29/01/2022.
//


import Foundation

// try use with array struct that holds the landmark
// and remove the [Landmark] from the decoder



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
