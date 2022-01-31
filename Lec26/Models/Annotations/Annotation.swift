//
//  Annotation.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 31/01/2022.
//

import MapKit

class Annotation:NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    init(_ coordinate: CLLocationCoordinate2D,
         title:String? = nil,
         subtitle: String? = nil)
    {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
    }
    
}
