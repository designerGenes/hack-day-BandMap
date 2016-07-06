//
//  ZipObject.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

// ZipObject represents a zip code.  For this demonstration
// it is used to hold the details that center the map

class ZipObject: NSObject {
  var events = [EventObject]()
  var zipCode: String?
  var span: Float?
  var guesstimateCoord: CLLocation?
  
  var retrievedJSON: JSON?
  
  func dissectJSON(obj: JSON) {
    zipCode = obj["zip"].stringValue
    if let eventsList = obj["events"].array {
      for event in eventsList {
        let newEvent = EventObject(obj: event, zip: self)
        events.append(newEvent)
      }
      print("loaded \(events.count) events into ZIP \(zipCode!)")
    }
  }
  
  init(obj: JSON) {
    super.init()
    dissectJSON(obj)
  }
  
}