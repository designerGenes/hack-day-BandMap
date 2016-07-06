//
//  AppDelegate.swift
//  BandMap
//
//  Created by Jaden Nation on 6/29/16.
//  Copyright © 2016 Jaden Nation. All rights reserved.
//

import UIKit
import SwiftyJSON


var globalColor: UIColor = UIColor(hexString: "#673AB7")  // start as purple

func resetGlobalColor() {
  var colorsList = [UIColor]()
  colorsList = colors.values.map({$0})
    let cleanedList = colorsList.filter({$0.hexValue() != globalColor.hexValue() })
    globalColor = cleanedList[rollDice(cleanedList.count)]
    print(globalColor.hexValue())
  
  
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var zip: ZipObject?
  
  func loadJSONObject() -> JSON? {
    if let path = NSBundle.mainBundle().pathForResource("json/dummy-data", ofType: "json") {
      do{
        let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
        let JSONobj = JSON(data: data)
        if JSONobj != JSON.null {
          return JSONobj
        }
      } catch {
        return nil
      }
    }
    return nil
  }


  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    if let jsonObj = loadJSONObject() {
        zip = ZipObject(obj: jsonObj)
    }
    
    return true
  }

  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

