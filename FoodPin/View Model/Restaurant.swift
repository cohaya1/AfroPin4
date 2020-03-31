//
//  Restaurant.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 1/17/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import Foundation


    class Restaurant {
    var name : String
    var type : String
    var location : String
    var image : String
    
    var phone : String
    var description : String
    var isVisited : Bool
        var rating : String
        init(name: String, type : String, location : String , image: String, phone : String, description : String,isVisited: Bool, rating : String = "") {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.phone = phone
        self.description = description
        self.isVisited = isVisited
            self.rating = rating
    }
    convenience init() {
        self.init(name:"",type:"",location:"",image:"", phone:"",description:"",isVisited: false)
    }
    

}
