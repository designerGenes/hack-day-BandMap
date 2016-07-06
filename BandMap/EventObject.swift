//
//  EventObject.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import SwiftyJSON

class EventAnnotation: NSObject, MKAnnotation {
  var title: String? {
    return master?.leadArtist
  }
  var subtitle: String? {
    return master?.website.absoluteString
  }
  var coordinate: CLLocationCoordinate2D
  var master: EventObject?
  
  init(master: EventObject) {
    
    self.coordinate = master.coordinate
    self.master = master
  }
  
}

struct EventObject {
  var name: String // "Young Empires Big Fat Party",
  var leadArtist: String // "Young Empires",
  var venue: String // "The Egyptian Theater",
  var doorsOpenAt: Int // "0900",
  var website: NSURL // "http://egyptiantheater.com",
  var address: String? // "6712 Hollywood Blvd, Los Angeles CA 90028",
  var coordinate: CLLocationCoordinate2D // -118.336505, 34.100906
  weak var zip: ZipObject?
  
  
  // annotation properties
  
  
  init(obj: JSON, zip: ZipObject) {
    name = obj["name"].stringValue
    leadArtist = obj["leadArtist"].stringValue
    venue = obj["venue"].stringValue
    doorsOpenAt = convertToTime(obj["doorsOpenAt"].stringValue)
    website = NSURL(string: obj["website"].stringValue)!
    address = obj["address"].stringValue
    let coord = obj["coordinates"]
    let longitude = coord["long"].doubleValue
    let latitude = coord["lat"].doubleValue
    coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    
    self.zip = zip
    
    print(name)
  }

}