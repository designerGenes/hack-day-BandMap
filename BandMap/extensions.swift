//
//  extensions.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation

func convertToTime(strTime: String) -> Int {
  
  return 0
}

extension String {
  func handleBebas() -> String {
    return self.stringByReplacingOccurrencesOfString(" ", withString: "   ")
  }
  
  func returnFirstXWords(x: Int) -> String {
    let strArr = self.componentsSeparatedByString(" ")
    var outStr = ""
    for (y, str) in strArr.enumerate() {
      if y < x {
        outStr += " \(str)"
      }
    }
    return outStr
  }
  
}