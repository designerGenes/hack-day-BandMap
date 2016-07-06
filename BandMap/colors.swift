//
//  colors.swift
//  BandMap
//
//  Created by Jaden Nation on 6/30/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

enum Color: String {
  case blue = "#254E70"
  case orange = "#FE4E00"
  case yellow = "#FFB82B"
  case blue_dark = "#13293D"
  case purple = "#5F5AA2"
}

let colors: [Color: UIColor] = [
  .blue: UIColor(hexString: Color.blue.rawValue),
  .orange: UIColor(hexString: Color.orange.rawValue),
  .yellow: UIColor(hexString: Color.yellow.rawValue),
  .blue_dark: UIColor(hexString: Color.blue_dark.rawValue),
  .purple: UIColor(hexString: Color.purple.rawValue)
]