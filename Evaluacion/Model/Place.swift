//
//  Place.swift
//  Evaluacion
//
//  Created by Ricardo Aguilar on 3/5/19.
//

import UIKit

class Place: NSObject {
    
    //MARK:- Variables
    var placeID: String!
    var name: String!
    var address: String!
    var category: String!
    var isOpen: Bool!
    var latitude: Double!
    var longitude: Double!
    var thumbnail: String!
    var rating: Double!
    var isPetFriendly: Bool!
    var addressLine1: String!
    var addressLine2: String!
    var phoneNumber: String!
    var site: String!
    var distance: Double! = 0
    
    //MARK:- Methods
    static func initPlace(_ json: [String: Any]) -> Place {
        let newPlace = Place()
        
        if let placeId = json["PlaceId"] as? String {
            newPlace.placeID = placeId
        }
        
        if let name = json["PlaceName"] as? String {
            newPlace.name = name
        }
        
        if let address = json["Address"] as? String {
            newPlace.address = address
        }
        
        if let category = json["Category"] as? String {
            newPlace.category = category
        }
        
        if let isOpen = json["IsOpenNow"] as? Bool {
            newPlace.isOpen = isOpen
        }
        
        if let latitude = json["Latitude"] as? Double {
            newPlace.latitude = latitude
        }
        
        if let longitude = json["Longitude"] as? Double {
            newPlace.longitude = longitude
        }
        
        if let thumbnail = json["Thumbnail"] as? String {
            newPlace.thumbnail = thumbnail
        }
        
        if let rating = json["Rating"] as? Double {
            newPlace.rating = rating
        }
        
        if let isPetFriendly = json["IsPetFriendly"] as? Bool {
            newPlace.isPetFriendly = isPetFriendly
        }
        
        if let addressLine1 = json["AddressLine1"] as? String {
            newPlace.addressLine1 = addressLine1
        }
        
        if let addressLine2 = json["AddressLine2"] as? String {
            newPlace.addressLine2 = addressLine2
        }
        
        if let phone = json["PhoneNumber"] as? String {
            newPlace.phoneNumber = phone
        }
        
        if let site = json["Site"] as? String {
            newPlace.site = site
        }
        
        return newPlace
    }
}
