//
//  DayManager.swift
//  The Day
//
//  Created by Hanul Park on 9/16/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import UIKit
import CoreData

class DayManager: NSObject {
    
    class func sharedStore() -> DayManager {
        
        struct Static {
            static var instance: DayManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token, {
            Static.instance = DayManager()
        })
        
        return Static.instance!
    }
    
    let DAYS: String = "Days"
    
    let aliasKey: String = "alias"
    let countTypeKey: String = "countType"
    let createdAtKey: String = "createdAt"
    let startDateKey: String = "startDate"
    let favoriteKey: String = "favorite"
    
    var days: NSMutableArray = NSMutableArray()
    let context: CoreDataHelper
    
    override init() {
        
        context = CoreDataHelper()
        
        var error: NSError?
        var fetchReq: NSFetchRequest = NSFetchRequest(entityName: DAYS)
        
        fetchReq.returnsObjectsAsFaults = false
        var result: NSArray = context.backgroundContext!.executeFetchRequest(fetchReq, error: nil)!
        
        for object: AnyObject in result {
            var day: Days = object as Days
            days.addObject(day)
        }
    }
    
    func addDay(alias: String, countType: String, createdAt: NSDate, startDate: NSDate, favorite: Bool) {

        var newDay: Days = NSEntityDescription.insertNewObjectForEntityForName(DAYS, inManagedObjectContext: context.backgroundContext!) as Days
        
        newDay.alias = alias
        newDay.countType = countType
        newDay.createdAt = createdAt
        newDay.startDate = startDate
        newDay.favorite = favorite
        
        context.saveContext()
        
        days.addObject(newDay)
    }
    
    func removeDay(object: Days) {
        
        var fetchReq = NSFetchRequest(entityName: DAYS)
        context.backgroundContext?.deleteObject(object)
        
        var error: NSError?
        context.managedObjectContext?.save(&error)
        
        if (error != nil) {
            print(error)
        } else {
            days.removeObject(object)
        }
    }
    
}