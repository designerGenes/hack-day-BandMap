//
//  extensions.swift
//
//
//  Created by Jaden Nation on 12/30/15.
//  Copyright © 2015 Jaden Nation. All rights reserved.
//



import Foundation
import UIKit

// MARK:  PROTOCOLS

protocol RawRepresentable {
  associatedtype Raw
  static func fromRaw(raw: Raw) -> Self?
  func toRaw() -> Raw
}

public protocol Numeric {
  //  associatedtype Self
  func +(lhs: Self, rhs: Self) -> Self
  func -(lhs: Self, rhs: Self) -> Self
  func *(lhs: Self, rhs: Self) -> Self
  func /(lhs: Self, rhs: Self) -> Self
  func %(lhs: Self, rhs: Self) -> Self
  init(_ v:Self)
  
}
extension Double : Numeric { }
extension Float  : Numeric { }
extension Int    : Numeric { }
extension Int8   : Numeric { }
extension Int16  : Numeric { }
extension Int32  : Numeric { }
extension Int64  : Numeric { }
extension UInt   : Numeric { }
extension UInt8  : Numeric { }
extension UInt16 : Numeric { }
extension UInt32 : Numeric { }
extension UInt64 : Numeric { }






// MARK:  ENUMS
public enum ViewInquiry {
  case topLeft
  case topRight
  case bottomLeft
  case bottomRight
  case center
  case frameSize
}

public enum Direction {
  case up
  case down
  case left
  case right
}

// MARK: extendedVC

//@objc protocol ExtendedVC {
//  var model: ViewModel? { get set }
//  var movesWithKeyboard: Bool { get set }
//  func keyboardWillShow(notification: NSNotification)
//  func keyboardWillHide(notification: NSNotification)
//}
//
//extension ExtendedVC where Self: UIViewController {
//  
//  func keyboardWillShow(notification: NSNotification) {
//    print("showing keyboard from extension")
//    if movesWithKeyboard == true {
//      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//        self.view.frame.origin.y -= keyboardSize.height
//      }
//    }
//  }
//  
//  func keyboardWillHide(notification: NSNotification) {
//    if movesWithKeyboard == true {
//      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//        self.view.frame.origin.y += keyboardSize.height
//      }
//    }
//  }
//  
//  func toggleMovesWithKeyboard() {
//    movesWithKeyboard = !movesWithKeyboard
//    if movesWithKeyboard == true {
//      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
//      NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
//    } else {
//     // code here to remove observers for keyboard
//    }
//  }
//  
//  
//  
//  func loadViewFromNib(nibName: String) -> UIView? {
//    let nib = UINib(nibName: nibName, bundle: NSBundle.mainBundle())
//
//    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
//
//    return view
//  }
//  
//}

public class ExtendedVC: UIViewController {
  public var model: ViewModel! // don't break this you fuck
  public var primaryColor: UIColor? ; public var secondaryColor: UIColor?
  public var movesWithKeyboard: Bool? {
    didSet {
      if oldValue == nil && movesWithKeyboard == true {
        print("added observers")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
      }
    }
  }
  
  public func toggleMovesWithKeyboard() {
    
  }
  
  public func keyboardWillShow(notification: NSNotification) {
    if movesWithKeyboard == true {
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
        self.view.frame.origin.y -= keyboardSize.height
      }
    }
  }
  
  public func keyboardWillHide(notification: NSNotification) {
    if movesWithKeyboard == true {
      if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
        self.view.frame.origin.y += keyboardSize.height
      }
    }
  }
  
  public func addSubViewThen(view: UIView) -> UIView {
    self.view.addSubview(view)
    return view
  }
  
  public func loadViewFromNib(nibName: String) -> UIView? {
    let nib = UINib(nibName: nibName, bundle: NSBundle.mainBundle())
    
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
  //  func performSegueWithIdentifier(identifier: Segue, sender: AnyObject?) {
  //    performSegueWithIdentifier(identifier.rawValue, sender: sender)
  //  }
  
  
} // end class


// MARK: viewModel
public class ViewModel: NSObject {
  public var master: UIViewController
  
  public init(_master: UIViewController) { self.master = _master  }
  
}

// MARK:  UICOLOR

public extension UIColor {
  public func darkenBy(percent: CGFloat) -> UIColor {
    var h, s, b, a: CGFloat
    h = 0.0; s = 0.0; b = 0.0; a=0.0
    self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    
    if (percent > 0) {
      b = min(b-percent, 1.0)
    }
    
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    
  }
  
  public func lightenBy(percent: CGFloat) -> UIColor {
    var h, s, b, a: CGFloat
    h = 0.0; s = 0.0; b = 0.0; a=0.0
    self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
    
    if (percent > 0) {
      b = min(b+percent, 1.0)
    }
    
    return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
    
  }
  
  public func hexRepresentation() -> String {
    var out: String = ""
    var h, s, v, a: CGFloat
    h = 0; s = 0; v = 0; a=0;
    if self.getHue(&h, saturation: &s, brightness: &v, alpha: &a) {
      
    }
    
    return out
  }
}

// MARK: CGFloat
extension CGFloat {
  func roundTo(x: Int) -> CGFloat {
    return CGFloat(x) * (round(self / CGFloat(x)))
  }
}

// MARK: LOADABLE VIEW
protocol LoadableView: class {
  var contentView: UIView! { get set }
  var nibName: String! { get set }
}

extension LoadableView where Self: UIView {
  
  func xibSetup() {
    contentView = loadViewFromNib()
    contentView.frame = bounds
    contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
    addSubview(contentView)
  }
  
  func loadViewFromNib() -> UIView {
    let bundle = NSBundle(forClass: self.dynamicType)
    let nib = UINib(nibName: nibName, bundle: bundle)
    let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
    
    return view
  }
  
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    xibSetup()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    super.init(coder: aDecoder)
//    xibSetup()
//  }
}

// MARK:  UIVIEW
public extension UIView {
  
  func setAnchorPoint(anchorPoint: CGPoint) {
    var newPoint = CGPointMake(bounds.size.width * anchorPoint.x, bounds.size.height * anchorPoint.y)
    var oldPoint = CGPointMake(bounds.size.width * layer.anchorPoint.x, bounds.size.height * layer.anchorPoint.y)
    
    newPoint = CGPointApplyAffineTransform(newPoint, transform)
    oldPoint = CGPointApplyAffineTransform(oldPoint, transform)
    
    var position = layer.position
    position.x -= oldPoint.x
    position.x += newPoint.x
    
    position.y -= oldPoint.y
    position.y += newPoint.y
    
    layer.position = position
    layer.anchorPoint = anchorPoint
  }
  
  public func blur(alpha: CGFloat, style: UIBlurEffectStyle, _ closure: (()->())? = nil) {
    let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
    blurView.alpha = 0 ; blurView.frame = self.frame
    let screen = UIScreen.mainScreen()
    blurView.center = CGPoint(x: screen.bounds.width/2, y: screen.bounds.height/2)
    self.addSubview(blurView)
    animateThen(0.35, animations: {
      blurView.alpha = alpha
      }, {
        SAFE(closure) { $0() }
    })
  }
  
  public func unBlur(_ closure: (()->())? = nil) {  //  NOT SAFE w/Nikki Glaser
    SAFE(self.subviews.filter({ SAFECAST($0, type: UIVisualEffectView.self)}).first) { blurView in
      animateThen(0.35, animations: {
        blurView.alpha = 0
        }, {
          SAFE(closure) { $0() }
          blurView.removeFromSuperview()
      })
    }
  }
  
  
  public subscript(index: ViewInquiry) -> [CGPoint] {
    var out: [CGPoint]
    let origin = frame.origin
    let topLeft = origin ; let topRight = CGPointMake(origin.x + frame.width, origin.y)
    let bottomLeft = CGPointMake(origin.x, origin.y + frame.height)
    let bottomRight = CGPointMake(origin.x + frame.width, origin.y + frame.height)
    
    
    switch index {
    case .topLeft: out = [topLeft]
    case .topRight: out = [topRight]
    case .bottomLeft: out = [bottomLeft]
    case .bottomRight: out = [bottomRight]
    case .frameSize: out = [topLeft, topRight, bottomLeft, bottomRight]
    case .center: out = [self.center]
    }
    
    return out
  }
  
  public func scale(z: CGFloat) {
    self.transform = CGAffineTransformMakeScale(z, z)
  }
  
  
  public func translate(x: CGFloat, y: CGFloat) {
    self.transform = CGAffineTransformMakeTranslation(x, y)
  }
  
  
  public func slide(direction: Direction, distanceAndTime: (distance: CGFloat, time: NSTimeInterval)?, closure: (()->())? = nil) {
    var cleanedDistance: CGFloat = 0
    var time = 0.35
    SAFE(self.superview) { SV in
      if let distance = distanceAndTime {
        cleanedDistance = distance.distance
        time = distance.time
      } else {
        switch direction {
        case .down, .up: cleanedDistance = SV.frame.height
        case .left, .right: cleanedDistance = SV.frame.width
        }
        
      }
      
      
      let transformation: CGAffineTransform
      switch direction {
      case .up :
        transformation = CGAffineTransformMakeTranslation(0, -cleanedDistance)
      case .down :
        transformation = CGAffineTransformMakeTranslation(0, cleanedDistance)
      case .left :
        transformation = CGAffineTransformMakeTranslation(-cleanedDistance, 0)
      case .right :
        transformation = CGAffineTransformMakeTranslation(cleanedDistance, 0)
      }
      
      
      animateThen(time, animations: {
        self.transform = transformation
      }) { SAFE(closure) { $0() } }
    }
  }
  
  
  public func fadeIn(time: NSTimeInterval = 0.5) {
    if self.alpha < 0.1 {
      animate(time) { self.alpha = 1 }
    }
  }
  public func fadeOut(time: NSTimeInterval = 0.5) {
    if self.alpha > 0.9 {
      animate(time) { self.alpha = 0 }
    }
  }
  public func roundCorners() { self.layer.cornerRadius = self.frame.width / 2 ; self.clipsToBounds = true }
  
  // this might come back to bite us.  this should extend UIView
  
}


// MARK:  UIBUTTON







// MARK: PUBLIC FUNCTIONS
public func SAFE<T>(opt: T?, closure: ((T)->())? = nil) -> Bool {
  if let unwrappedOpt = opt {
    if let closure = closure {
      closure(unwrappedOpt)
    }
    return true
  }
  return false
}

public func SAFECAST<T, U>(opt: T?, type: U.Type, closure: ((U) -> ())? = nil) -> Bool {
  if let opt = opt {
    if opt is U {
      if let closure = closure { closure(opt as! U) }
      return true
    }
  }
  return false
}

public func NOTSAFE<T>(x:T?, _ closure: ()->(T)) -> T {
  if x == nil {
    return closure()
  }
  return x!
}


infix operator ∆ { associativity left precedence 160 }
public func ∆<T: Numeric where T: Comparable>(lhs: T, rhs: T) -> T {
  if rhs > lhs { return rhs ∆ lhs }
  return  lhs - rhs
}

func getAppDelegate() -> AppDelegate { return UIApplication.sharedApplication().delegate as! AppDelegate }

public func rollDice(sides: Int) -> Int {
  let out = arc4random_uniform(UInt32(sides)) % UInt32(sides)
  return Int(out)
}


public func flipCoin() -> Int {
  let out = arc4random_uniform(2) % UInt32(2)
  return Int(out)
}

public func flipCoin(outcomes: [String]) -> String? {
  let out = Int(arc4random_uniform(2) % UInt32(2))
  if out > (outcomes.count-1) || out == 0 { flipCoin(outcomes) }
  return outcomes[out]
}

func extractHEXString(color: CGColor) -> String {
  return extractHEXString(UIColor(CGColor: color))
}


func extractHEXString(color: UIColor) -> String {
  var r, g, b, a: CGFloat
  r = 0 ; g = 0; b = 0; a = 0;
  var out: String = ""
  if color.getRed(&r, green: &g, blue: &b, alpha: &a) == true {
    var red = NSString(format: "%1X", Int(r*255))
    var green = NSString(format: "%1X", Int(g*255))
    var blue = NSString(format: "%2X", Int(b*255))
    let alpha = NSString(format: "%2X", Int(a*100))
    [red, green, blue].map { color in
      if color.isEqualToString("0") {
        out += "00"
      } else {
        out += color as String
      }
    }
    
  }
  return out
}

public extension NSTimer {
  /**
   Creates and schedules a one-time `NSTimer` instance.
   
   :param: delay The delay before execution.
   :param: handler A closure to execute after `delay`.
   
   :returns: The newly-created `NSTimer` instance.
   */
  public class func schedule(delay delay: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
    let fireDate = delay + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
    return timer
  }
  
  /**
   Creates and schedules a repeating `NSTimer` instance.
   
   :param: repeatInterval The interval between each execution of `handler`. Note that individual calls may be delayed; subsequent calls to `handler` will be based on the time the `NSTimer` was created.
   :param: handler A closure to execute after `delay`.
   
   :returns: The newly-created `NSTimer` instance.
   */
  public class func schedule(repeatInterval interval: NSTimeInterval, handler: NSTimer! -> Void) -> NSTimer {
    let fireDate = interval + CFAbsoluteTimeGetCurrent()
    let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
    return timer
  }
}

//
//public func downloadImageIntoArray(inout sourceArray: [UIImage], url: NSURL){
//  getDataFromUrl(url) { (data, response, error)  in
//    dispatch_async(dispatch_get_main_queue()) { () -> Void in
//      guard let data = data where error == nil else { return }
//        sourceArray.append(UIImage(data: data)!)
//    }
//  }
//}



//public func getAppDelegate() -> AppDelegate {
//  return UIApplication.sharedApplication().delegate as! AppDelegate
//}



public func wait(time: NSTimeInterval, closure: (()->())? = nil) {
  NSTimer.schedule(delay: time) { timer in
    SAFE(closure) { $0() }
  }
}


public func getDataFromUrl(url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
  NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
    completion(data: data, response: response, error: error)
    }.resume()
}


public func PF(name: String) {
  print("-\t-\t-\t-\t-")
  print("entering function \(name)")
}

public func PC(className: String) {
  print("=\t=\t=\t=\t=")
  print("new instance of \(className)")
}

public func PS(segueName: String) {
  print("+\t+\t+\t+\t+")
  print("firing segue \(segueName)")
}


// mark: animations
public func animate(duration: NSTimeInterval, animations: ()->()) {
  UIView.animateWithDuration(duration, animations: animations)
}

public func animateForever(duration: NSTimeInterval, animations: ()->()) {
  UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.Repeat, animations: animations, completion: nil)
}

public func animateThenReverse(duration: NSTimeInterval, animations: ()->()) {
  UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions.Autoreverse, animations: animations, completion: nil)
}

public func animateWith(duration: NSTimeInterval, options: UIViewAnimationOptions, animations: ()->()) {
  UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: nil)
}

public func animateWait(duration: NSTimeInterval, delay: NSTimeInterval, animations: ()->(), _ completion: (()->())?) {
  UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.AllowUserInteraction , animations: animations, completion: { _ in
    if let finalTask = completion { finalTask() }
  })
}

public func animateWaitThen(duration: NSTimeInterval, _ delay: NSTimeInterval, animations: ()->(), _ completion: ()->()) {
  UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.AllowUserInteraction , animations: animations, completion: { _ in
    completion()
  })
}

public func animateWithAndThen(duration: NSTimeInterval, options: UIViewAnimationOptions, animations: ()->(), _ completion: ()->()) {
  UIView.animateWithDuration(duration, delay: 0, options: options, animations: animations, completion: { _ in
    completion()
  })
}

public func animateSpring(duration: NSTimeInterval, damping: CGFloat, speed: CGFloat, options: UIViewAnimationOptions, animations: ()->()) {
  UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: speed, options: options, animations: animations, completion: nil)
}

public func animateThen(duration: NSTimeInterval, animations: ()->(), _ completion: ()->()) {
  let _ = true
  UIView.animateWithDuration(duration, animations: animations, completion: { completed in
    if completed == true { completion() }
  })
}

public func animateWithDelay(time: NSTimeInterval, delay: NSTimeInterval, animations: ()->(), completion: ()->()) {
  let triggerTime = (Int64(NSEC_PER_SEC) * Int64(delay))
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
    UIView.animateWithDuration(time, animations: animations, completion:  { _ in
      completion()
    })
  })
}

public func wait(time: NSTimeInterval, completion: ()->()) {
  NSTimer.schedule(delay: time) { timer in
    completion()
  }
}

public func animateSequence(var animations: [(time: NSTimeInterval?, delay: NSTimeInterval?, animation: ()->() )]) {
  //  USAGE NOTES:
  //    for this to work, each animation's .TIME is how long the animation will take to finish.  This allows you to call functions which contain their own animations, and not fire off the next tuple in the animation sequence until its preceding animation can be expected to be have finished
  //    .DELAY just adds another pause
  
  
  if let animation = animations.first {
    if let time = animation.time {
      if let delay = animation.delay {                  //    Has delay
        animateWithDelay(time, delay: delay, animations: {
          animation.animation()
          }, completion: {
        })
      } else {
        animateThen(time, animations: {               //      Has duration
          animation.animation()
          }, {
        })
      }
    } else {                                          // if nil, just fire everything off and
      animation.animation()                           //  immediately move to next task
    }
    var delayBeforeProgressing: NSTimeInterval = 0
    if let safeTime = animation.time { delayBeforeProgressing += safeTime }
    if let safeDelay = animation.delay { delayBeforeProgressing += safeDelay }
    animateWithDelay(0, delay: delayBeforeProgressing, animations: {
      }, completion: {
        animations.removeFirst()
        animateSequence(animations)
    })
  }
  
  
}


// MARK: binary tree
public class Leaf: NSObject {
  public var id: Int
  
  init(id: Int) {
    self.id = id
    super.init()
  }
}


public class Tree: NSObject {
  var parent: Tree?
  var root: Leaf? ; var left: Tree? ; var right: Tree?
  
  //
  public func find(val: Int, _ counter: Int? = nil) -> Leaf? {
    var innerCounter: Int = 0
    if counter != nil { innerCounter = counter! }
    
    let root = self.root!
    if root.id == val {
      print("Found value at \(innerCounter) hops")
      return root
    } else if val > root.id {
      if let right = self.right {
        return right.find(val, innerCounter+1)
      }
    } else if val < root.id {
      if let left = self.left {
        return left.find(val, innerCounter+1)
      }
    }
    return nil
  }
  
  public func insert(val: Leaf) {
    var direction: String = "here"
    if let root = self.root {
      if val.id > root.id {
        direction = "right"
        if let right = self.right {
          right.insert(val)
        } else {
          self.right = Tree(parent: self)
          self.right!.insert(val)
        }
        
        
      } else if val.id < root.id {
        direction = "left"
        if let left = self.left {
          left.insert(val)
        } else {
          self.left = Tree(parent: self)
          self.left!.insert(val)
        }
      }
    } else {
      self.root = val
    }
    //    print("Inserting \(val.id) \(direction)")
  }
  
  public func processTree(tree: Tree) {
    insert(tree.root!)
    if tree.left != nil { processTree(tree.left!) }
    if tree.right != nil { processTree(tree.right!) }
  }
  
  public func displayTree() {
    
  }
  
  public override init() {
    super.init()
  }
  
  public init(parent: Tree) {
    self.parent = parent
    super.init()
  }
  
  
  
}

public func getMedianValue(arr: [Int]) -> Int {
  var median: Int
  if (arr.count + 1) & 2 == 0 { // if odd
    return arr[(arr.count-1)/2]
  } else { // if even
    return arr[(arr.count)/2]
  }
}

//func rollDice(sides: Int) -> Int {
//  return Int(arc4random_uniform(UInt32(sides)))
//}

public func generateArrayOfRandomShit(size: Int, maxValue: Int) -> [Int] {
  var out = [Int]()
  (0..<size).map { x in
    out.append(rollDice(maxValue))
  }
  return out
}

public func generateSet(size: Int, maxValue: Int) -> [Int] {
  return Set(generateArrayOfRandomShit(size, maxValue: maxValue)).map({$0})
}



// MARK: dispatch
public var GlobalMainQueue: dispatch_queue_t {
  return dispatch_get_main_queue()
}

public var GlobalUserInteractiveQueue: dispatch_queue_t {
  return dispatch_get_global_queue(Int(QOS_CLASS_USER_INTERACTIVE.rawValue), 0)
}

public var GlobalUserInitiatedQueue: dispatch_queue_t {
  return dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)
}

public var GlobalUtilityQueue: dispatch_queue_t {
  return dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue), 0)
}

public var GlobalBackgroundQueue: dispatch_queue_t {
  return dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0)
}

public func dispatchToBackground(closure: ()->()) {
  let GRP_holdIt = dispatch_group_create()
  
  dispatch_group_enter(GRP_holdIt)
  dispatch_async(GlobalBackgroundQueue, closure)
  dispatch_group_leave(GRP_holdIt)
}
public func dispatchToMain(closure: ()->()) {
  let GRP_holdIt = dispatch_group_create()
  
  dispatch_group_enter(GRP_holdIt)
  dispatch_async(GlobalMainQueue, closure)
  dispatch_group_leave(GRP_holdIt)
}


public func inDispatch(group: dispatch_group_t) { dispatch_group_enter(group) }
public func outDispatch(group: dispatch_group_t) { dispatch_group_leave(group) }


public func waitDispatch(group: dispatch_group_t) { dispatch_group_wait(group, DISPATCH_TIME_FOREVER) }
public func notifyDispatch(group: dispatch_group_t, queue: dispatch_queue_t, block: ()->()) { dispatch_group_notify(group, queue, block) }


public func dispatchToUserInteractive(closure: ()->()) { dispatch_async(GlobalUserInteractiveQueue, closure)}
public func dispatchToUserInitiated(closure: ()->()) { dispatch_async(GlobalUserInitiatedQueue, closure)}
public func dispatchToGlobalUtility(closure: ()->()) { dispatch_async(GlobalUserInteractiveQueue, closure)}
