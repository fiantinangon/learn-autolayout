//
//  CustomSubHeader.swift
//  autolayout
//
//  Created by Alfian on 2/3/16.
//  Copyright © 2016 Alfian. All rights reserved.
//

import UIKit

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
