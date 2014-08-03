//
//  ListViewController.swift
//  The Day
//
//  Created by Hanul Park on 7/27/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView: UITableView!
    var segmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    func setupView() {
        let navigationbarHeight = self.navigationController.navigationBar.frame.origin.y
        self.segmented = UISegmentedControl(items: ["a", "b"])
        self.segmented.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(self.segmented)
        
        self.tableView = UITableView()
        self.tableView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.view.addSubview(self.tableView)
        
        let viewsDictionary = ["segmented":self.segmented, "tableView":self.tableView]
        let segmentContrainPosV = NSLayoutConstraint.constraintsWithVisualFormat("V:[segmented(44)]", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)
        let segmentContrainPosH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[segmented]-10-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(segmentContrainPosV)
        self.view.addConstraints(segmentContrainPosH)
        
        let tableViewContrainPosH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[tableView]-10-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(tableViewContrainPosH)
        
        let constraintPosV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-74-[segmented]-10-[tableView]-49-|", options: NSLayoutFormatOptions.AlignAllLeading, metrics: nil, views: viewsDictionary)
        
        self.view.addConstraints(constraintPosV)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = "\(indexPath.row)"
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
    }
}
