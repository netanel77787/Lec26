//
//  LandmarkAnnotations.swift
//  Lec26
//
//  Created by Netanel Mantsoor on 31/01/2022.
//

class LandmarkAnnotation: Annotation{
    //props:
    let landmark: Landmark
    //init
    init(landmark: Landmark){
        self.landmark = landmark
        super.init(landmark.coordinate,
                   title: landmark.name,
                   subtitle: landmark.vendorName)
        
    }
    
}
