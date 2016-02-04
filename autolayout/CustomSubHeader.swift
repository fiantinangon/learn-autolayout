//
//  CustomSubHeader.swift
//  autolayout
//
//  Created by Alfian on 2/3/16.
//  Copyright © 2016 Alfian. All rights reserved.
//

import UIKit

@IBDesignable class CustomSubHeader: UIView {
    
    
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSwitch: UISwitch!
    
    var view:UIView!

    
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
//        self.transla / tesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass:self.dynamicType)
        let nib = UINib(nibName: "CustomSubHeader", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    
    
}
