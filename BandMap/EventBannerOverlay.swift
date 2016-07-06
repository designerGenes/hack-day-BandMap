//
//  VenueBannerOverlay.swift
//  BandMap
//
//  Created by Jaden Nation on 6/30/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit

class EventBannerOverlay: UIView, LoadableView {
  
  // MARK: outlets
  @IBOutlet weak var lblBandName: UILabel!
  @IBOutlet weak var btnDismiss: UIButton!
  
  @IBAction func clickedDismiss(sender: UIButton) { doClickedDismiss()  }
  
  // MARK: variables
  var contentView: UIView!
  var nibName: String! = "EventBannerOverlay"
  var delegate: OverlayDelegate?
  
  func translateIntoView(obj: EventObject) {
    contentView.backgroundColor = globalColor
    lblBandName.text = obj.leadArtist.handleBebas()
  }
  
  // MARK: custom methods
  func doClickedDismiss() {
    btnDismiss.animation.rotate(90).animateWithCompletion(0.2) {
      SAFE(self.delegate) { $0.didClickDismiss() }
    }
  }
  
  // MARK: init methods
  init(frame: CGRect, master: EventObject, delegate: OverlayDelegate) {
    super.init(frame: frame)
    xibSetup()
    
    
    
    self.delegate = delegate
    delegate.willShowOverlay(self)
    contentView.backgroundColor = UIColor(gradientStyle: .LeftToRight , withFrame: self.frame, andColors: [globalColor, globalColor.darkenBy(0.3) ])
    
    translateIntoView(master)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

}
