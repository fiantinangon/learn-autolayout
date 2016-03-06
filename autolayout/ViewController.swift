//
//  ViewController.swift
//  autolayout
//
//  Created by Alfian on 2/1/16.
//  Copyright © 2016 Alfian. All rights reserved.
//

import UIKit




//MARK:

class ViewController: UIViewController,CustomHeaderDelegate {
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var mButton1: UIButton!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mRecomendedContainer: UIView!
    @IBOutlet weak var cHeightRecomendedContainer: NSLayoutConstraint!
    @IBOutlet weak var mButtonSave: UIButton!
    @IBOutlet weak var mViewLoading: UIView!
    @IBOutlet weak var cLoadingCenterX: NSLayoutConstraint!
    @IBOutlet weak var cLoadingContainerCenterY: NSLayoutConstraint!
    @IBOutlet weak var mViewSubHeader: CustomSubHeader!
    @IBOutlet weak var tes: UITextView!
    
    // MARK: INIT VARIABLE
    
    let string1 = "$500.00"
    let string2 = "$720"
    
    
    // MARK: ACTION

    @IBAction func changeText(sender: AnyObject) {
        if cHeightRecomendedContainer.constant == 35.0 {
            cHeightRecomendedContainer.constant = 142
        }else {
            cHeightRecomendedContainer.constant = 35.0
            mRecomendedContainer.constraints
        }
        
        UIView.animateWithDuration(Double(0.5), animations: {
            self.view.layoutIfNeeded()
        })
        
        updateUI()
    }
    
    @IBAction func actionSave(sender: AnyObject) {
        let duration = 1.0
        let delay = 0.0
        let options = UIViewAnimationOptions.CurveEaseInOut
        let damping:CGFloat = 0.5 // set damping ration
        let velocity:CGFloat = 1.0 // set initial velocity
        
        UIView.animateWithDuration(duration, delay: delay, usingSpringWithDamping: damping, initialSpringVelocity: velocity, options: options, animations: ({
            
            self.showLoading()
            self.view.layoutIfNeeded()
            
        }), completion: nil)
        
        let seconds = 4.0
        let delayTime = seconds * Double(NSEC_PER_SEC)  // nanoseconds per seconds
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayTime))
        
        dispatch_after(dispatchTime, dispatch_get_main_queue(), {
            
            UIView.animateWithDuration(Double(0.5), animations: {
                self.hideLoading()
                self.view.layoutIfNeeded()
            })
            
        })
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        mViewSubHeader.delegate = self
        hideLoading()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:LOADING
    
    func hideLoading() {
        
        let screenHeight = CGRectGetHeight(view.bounds)
        let loadingPosition = screenHeight/2.0 + mViewLoading.bounds.height/2
        
        cLoadingContainerCenterY.constant = -loadingPosition
        
    }
    
    func showLoading() {

        cLoadingContainerCenterY.constant = 0
        
    }
    
    //MARK:UI
    
    func updateUI() {
        let priceString:NSString = string1 + " " + string2
        var atributedPriceString = NSMutableAttributedString()
        
        atributedPriceString = NSMutableAttributedString(string: priceString as String, attributes: [NSFontAttributeName:UIFont(name: "Helvetica Neue", size: 14.0)!])
        
        atributedPriceString.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:0,length:string1.characters.count))
        
        
        mLabel.attributedText = atributedPriceString
        
        
    }
    
    //MARK:DELEGATE METHOD
    
    func setData(data: NSString) {
        mLabel.text = data as String
        
        let alert = UIAlertController(title: "CUSTOM VIEW DELEGATE", message: "SWITCH " + (data as String), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    

}


