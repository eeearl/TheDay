//
//  PageContentViewController.swift
//  The Day
//
//  Created by Hanul Park on 7/25/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import UIKit

class PageContentViewController: UIViewController {

    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""

    @IBOutlet strong var backgroundImageView: UIImageView!
    @IBOutlet strong var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var image:UIImageView = UIImageView()
        image.setTranslatesAutoresizingMaskIntoConstraints(false)
        image.image = UIImage(named: imageFile)
        self.view.addSubview(image)
        
        let viewsDictionary = ["image":image]
        
        //let contrainH = NSLayoutConstraint.constraintsWithVisualFormat("V:[a(100)]", options: NSLayoutFormatOptions.AlignAllLeft, metrics: nil, views: viewsDictionary)
        //let contrainV = NSLayoutConstraint.constraintsWithVisualFormat("H:[a(100)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)
        let contrainPosV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[image]-0-|",
            options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)
        let contrainPosH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[image]-0-|",
            options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)

        
        //image.addConstraints(contrainH)
        //image.addConstraints(contrainV)
        
        self.view.addConstraints(contrainPosV)
        self.view.addConstraints(contrainPosH)
        
    }
}