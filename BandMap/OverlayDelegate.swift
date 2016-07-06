//
//  OverlayDelegate.swift
//  BandMap
//
//  Created by Jaden Nation on 6/30/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import Foundation
import UIKit

protocol OverlayDelegate {
  func didClickDismiss()
  func willShowOverlay(obj: LoadableView)
//  optional func didShowOverlay()
//  optional func didHideOverlay()
//  optional func willHideOverlay()
}