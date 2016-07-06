//
//  ViewController.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import MapKit
import DKChainableAnimationKit
import ChameleonFramework

@objc class MainViewController: ExtendedVC, MKMapViewDelegate, OverlayDelegate {
  // MARK: outlets
  
  @IBOutlet weak var mapEvents: MKMapView!
  
  
  // MARK: variables
  let initialLoc = CLLocation(latitude: 21.282778, longitude: -157.829444)
  let regionRad: CLLocationDistance = 1000
  
  var zipObj: ZipObject?
  
  // MARK: custom methods
  func translateEventDataToView(focus: EventObject) {
    
    resetGlobalColor()
    
    // spawn upper overlay
    let banners = view.subviews.filter({$0 is EventBannerOverlay})
    if banners.count == 0 {  // spawn condition
      
      
      
      let upperFrame = CGRectMake(0, 0, view.frame.size.width, 80)
      let upperOverlay = EventBannerOverlay(frame: upperFrame, master: focus, delegate: self)
      view.addSubview(upperOverlay)
      upperOverlay.setAnchorPoint(CGPoint(x: 0, y: 1))
      upperOverlay.center = view.bounds.origin
      upperOverlay.alpha = 0
      upperOverlay.animation.makeAlpha(1).moveY(upperOverlay.frame.size.height).bounce.animate(0.25)
    } else {
      if let bOverlay = banners.first as? EventBannerOverlay {
        bOverlay.translateIntoView(focus)
      }
    }
    
    // spawn lower overlay
    let footers = view.subviews.filter({$0 is EventDetailsOverlay})
    if footers.count == 0 { // spawn condition
      let lowerFrame = CGRectMake(0, 0, view.frame.size.width, 120)
      let lowerOverlay = EventDetailsOverlay(frame:lowerFrame, obj: focus, delegate: self)
      view.addSubview(lowerOverlay)
      lowerOverlay.setAnchorPoint(CGPoint(x: 0, y: 0))
      lowerOverlay.center = CGPoint(x: 0, y: view.frame.size.height)
      lowerOverlay.alpha = 0
      lowerOverlay.animation.makeAlpha(1).moveY(-lowerOverlay.frame.size.height).animate(0.35)
    } else {
      if let fOverlay = footers.first as? EventDetailsOverlay {
        fOverlay.translateIntoView(focus)
      }
    }
  }
  
  
  
  
  // MARK: overlay delegate methods
  func willShowOverlay(obj: LoadableView) {
//    obj.contentView.backgroundColor = globalColor
  }
  
  func didClickDismiss() {
    tameAllPinsExcept(nil)
    if let detailOverlay = view.subviews.filter({$0 is EventDetailsOverlay}).first {
      detailOverlay.animation.makeAlpha(0.35).moveY(detailOverlay.frame.size.height).animateWithCompletion(0.25) {
        detailOverlay.removeFromSuperview()
      }
    }
    if let bannerOverlay = view.subviews.filter({$0 is EventBannerOverlay}).first {
      bannerOverlay.animation.makeAlpha(0.35).moveY(-bannerOverlay.frame.size.height).animateWithCompletion(0.35) {
        bannerOverlay.removeFromSuperview()
        SAFE(getAppDelegate().zip?.guesstimateCoord) {
          self.centerMapOn($0)
          self.mapEvents.deselectAnnotation(nil, animated: true)
        }
      }
    }
  }
  
  func tameAllPinsExcept(pin: MKAnnotationView?) {
    for anno in mapEvents.annotations {  //.map({$0.}) //.filter({$0 != view})
      if let annoView = mapEvents.viewForAnnotation(anno) {
        if annoView != pin { annoView.image = UIImage(named: "customPin_inactive")  }
      }
    }
    if let pin = pin {
      pin.image = UIImage(named: "customPin_active")
    }

  }
  
  // MARK: Map Kit delegate methods
  func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
    if let eAnnotation = view.annotation as? EventAnnotation {
      if let master = eAnnotation.master {
        tameAllPinsExcept(view)
        
        self.centerMapOn(CLLocation(latitude: eAnnotation.coordinate.latitude, longitude: eAnnotation.coordinate.longitude))
        translateEventDataToView(master)
      }
    }
  }
  
  func mapView(mapView: MKMapView, didDeselectAnnotationView view: MKAnnotationView) {

  }
  
  
  func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
  
  }
  
  func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    if let annotation = annotation as? EventAnnotation {
      var view: MKAnnotationView
      let id = "pin"
      if let dqView = mapView.dequeueReusableAnnotationViewWithIdentifier(id) {
        dqView.annotation = annotation
        dqView.image = UIImage(named: "customPin_inactive")
        view = dqView
      } else {
        view = MKAnnotationView(annotation: annotation, reuseIdentifier: id)
        view.image = UIImage(named: "customPin_inactive")
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -9, y: 5)
      }
      return view
    }
    return nil
  }
  
  func centerMapOn(loc: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, regionRad * 2.0, regionRad * 2.0)
    mapEvents.setRegion(coordinateRegion, animated: true)
  }
  
  func translateEventsToMap(events: [EventObject]) {
    
    // center the map based on average of event coords in zip object
    let averageLat = events.map({$0.coordinate.latitude}).reduce(0, combine: {$0 + $1}) / Double(events.count)
    let averageLong = events.map({$0.coordinate.longitude}).reduce(0, combine: {$0 + $1}) / Double(events.count)
    let guesstimateLocation = CLLocation(latitude: averageLat, longitude: averageLong)
    getAppDelegate().zip?.guesstimateCoord = guesstimateLocation
    centerMapOn(guesstimateLocation)
    
    // run through events and place on map
    for (x, event) in events.enumerate() {
      let newAnnotation = EventAnnotation(master: event)
      mapEvents.addAnnotation(newAnnotation)
    }
  }
  
  // MARK: init methods
  func didLoadStuff() {
    mapEvents.delegate = self
    if let zipObj = getAppDelegate().zip {
      translateEventsToMap(zipObj.events)
    } else {
      centerMapOn( initialLoc )
    }
    

  }
  
  func didAppearStuff() {
    
  }
  
  func willAppearStuff() {

  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    didLoadStuff()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    didAppearStuff()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    willAppearStuff()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}  // END OF VC