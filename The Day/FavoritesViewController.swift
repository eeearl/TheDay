//
//  ViewController.swift
//  The Day
//
//  Created by Hanul Park on 7/25/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
    var pageImages : Array<String> = ["page1", "page2", "page3"]
    var currentIndex : Int = 0
    

    override func viewDidLoad() {
        setupView()
        super.viewDidLoad()
    }

    func setupView() {
        self.pageViewController = UIPageViewController(transitionStyle: .Scroll,
            navigationOrientation: .Horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey:15.0])
        self.pageViewController!.dataSource = self
        
        var startingViewController: PageContentViewController = self.viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        self.pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        self.pageViewController!.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController!.view)
        self.pageViewController!.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerBeforeViewController viewController: UIViewController!) -> UIViewController!
    {
        var index = self.currentIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        println("Decreasing Index: \(String(index))")
        
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController!,
        viewControllerAfterViewController viewController: UIViewController!) -> UIViewController!
    {
        var index = self.currentIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        println("Increasing Index: \(String(index))")
        
        if (index == self.pageTitles.count) {
            return nil
        }
        
        return self.viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> PageContentViewController?
    {
        if self.pageTitles.count == 0 || index > self.pageTitles.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        var pageContentViewController = self.storyboard.instantiateViewControllerWithIdentifier("PageContentViewController") as PageContentViewController
        
        pageContentViewController.imageFile = self.pageImages[index]
        pageContentViewController.titleText = "aaa"//self.pageTitles[index]
        pageContentViewController.pageIndex = index
        
        self.currentIndex = index
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

// MARK: - Tap GestureRecognizer
    
    @IBAction func tapGestureRecognizer(sender: UITapGestureRecognizer) {
        self.navigationController.setNavigationBarHidden(!self.navigationController.navigationBarHidden, animated: true)
        self.setTabBarVisible(!self.tabBarIsVisible(), animated: true)
    }

// MARK: - TabBar Visible Methods
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        if self.tabBarIsVisible() == visible {
            return
        }
        
        // get a frame calculation ready
        var frame = self.tabBarController.tabBar.frame;
        var height = frame.size.height;
        var offsetY = visible ? -height : height
        
        // zero duration means no animation
        var duration = animated ? 0.2 : 0.0
        
        UIView.animateWithDuration(duration, animations: {
            self.tabBarController.tabBar.frame = CGRectOffset(frame, 0, offsetY)
            })
    }
    
    func tabBarIsVisible() -> Bool {
        return self.tabBarController.tabBar.frame.origin.y <
            CGRectGetMaxY(self.view.frame)
    }
}

