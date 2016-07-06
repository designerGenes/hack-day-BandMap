//
//  EventDetailsOverlay.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import ChameleonFramework

class EventDetailsOverlay: UIView, LoadableView {
  
  // MARK: outlets
  @IBOutlet weak var lblEventTitle: UILabel!
  @IBOutlet weak var lblVenueTitle: UILabel!
  @IBOutlet weak var lblEventDate: UILabel!
  @IBOutlet weak var lblEventTime: UILabel!
  @IBOutlet weak var btnMoreInfo: UIButton!
  @IBOutlet weak var btnBuyTickets: UIButton!
  @IBOutlet weak var viewContainsDetails: UIView!
  
  
  @IBAction func clickedButton(sender: UIButton) {
    sender.animation.moveY(10).animateWithCompletion(0.2) {
      sender.animation.moveY(-10).bounce.animate(0.2)
    }
  }
  
  
  @IBAction func clickedMoreInfo(sender: UIButton) { doClickedMoreInfo(sender)
    
  }
  
  @IBAction func clickedBuyTickets(sender: UIButton) { doClickedBuyTickets(sender)
  }
  
  
  
  
  // MARK: variables
  var nibName: String! = "EventDetailsOverlay"
  var contentView: UIView!
  var delegate: OverlayDelegate?
  
  func doClickedMoreInfo(btn: UIButton) {

    
    
  }
  
  func doClickedBuyTickets(btn: UIButton) {
    
  }
  
  func translateIntoView(obj: EventObject) {
    contentView.backgroundColor = globalColor
    viewContainsDetails.backgroundColor = contentView.backgroundColor?.darkenBy(0.1)
    viewContainsDetails.backgroundColor = UIColor(gradientStyle: .TopToBottom, withFrame: viewContainsDetails.bounds, andColors: [viewContainsDetails.backgroundColor!.darkenBy(0.2), viewContainsDetails.backgroundColor!])
    
    lblEventTitle.text = obj.name.returnFirstXWords(7) //.handleBebas()
    lblVenueTitle.text = obj.venue //.handleBebas()
    lblEventDate.text = "06/30/16"
    lblEventTime.text = "8:00 - 10:00"
  }
  
  
  init(frame: CGRect, obj: EventObject, delegate: OverlayDelegate) {
    super.init(frame: frame)
    xibSetup()
    
    self.delegate = delegate
    delegate.willShowOverlay(self)
    
    
    // round corners of buttons
    [btnMoreInfo, btnBuyTickets].map { btn in
      btn.layer.cornerRadius = btn.frame.size.width / 15
      btn.clipsToBounds = true
    }
    
    translateIntoView(obj)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

}
