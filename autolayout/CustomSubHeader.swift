//
//  CustomSubHeader.swift
//  autolayout
//
//  Created by Alfian on 2/3/16.
//  Copyright © 2016 Alfian. All rights reserved.
//

import UIKit

//MARK: EXTENSION

extension UILabel {
    
    @IBInspectable var kerning: Float {
        get {
            var range = NSMakeRange(0, (text ?? "").characters.count)
            guard let kern = attributedText?.attribute(NSKernAttributeName, atIndex: 0, effectiveRange: &range),
                value = kern as? NSNumber
                else {
                    return 0
            }
            return value.floatValue
        }
        set {
            var attText:NSMutableAttributedString?
            
            if let attributedText = attributedText {
                attText = NSMutableAttributedString(attributedString: attributedText)
            } else if let text = text {
                attText = NSMutableAttributedString(string: text)
            } else {
                attText = NSMutableAttributedString(string: "")
            }
            
            let range = NSMakeRange(0, attText!.length)
            attText!.addAttribute(NSKernAttributeName, value: NSNumber(float: newValue), range: range)
            self.attributedText = attText
        }
    }
}

protocol CustomHeaderDelegate {
    func setData(data:NSString)
}

@IBDesignable class CustomSubHeader: UIView {
    
    
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSwitch: UISwitch!
    
    var view:UIView!
    var delegate:CustomHeaderDelegate? = nil
    
    //MARK: INIT CUSTOM VIEW
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
        setup()
    }
    
    
    func setup()
    {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        //SET SWITCH ACTION
        mSwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "CustomSubHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    //MARK:DELEGATE
    
    func switchChanged(mySwitch: UISwitch) {
        let value = mySwitch.on
        
        if value == true {
            if (delegate != nil) {
                let data:NSString = "ACTIVATE"
                delegate!.setData(data)
            }
        }else {
            if (delegate != nil) {
                let data:NSString = "DEACTIVATE"
                delegate!.setData(data)
            }
        }
        
    }
    
    
    
}
