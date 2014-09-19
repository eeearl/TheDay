//
//  CoreDataHelper.swift
//  The Day
//
//  Created by Hanul Park on 9/16/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import CoreData
import UIKit

class CoreDataHelper: NSObject {
    
    let store: CoreDataStore!
    
    var appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override init() {
        super.init()
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.store = appDelegate.coreDataStore
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "contextDidSaveContext:", name: NSManagedObjectContextDidSaveNotification, object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
// MARK: - Core Data stack
    
    // main thread context
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // Returns the background object context for the application.
    // You can use it to process bulk data update in background.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var backgroundContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.store.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var backgroundContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.PrivateQueueConcurrencyType)
        backgroundContext.persistentStoreCoordinator = coordinator
        return backgroundContext
        }()
    
    
    // save NSManagedObjectContext
    func saveContext (context: NSManagedObjectContext) {
        var error: NSError? = nil
        if context.hasChanges && !context.save(&error) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
    }
    
    func saveContext () {
        self.saveContext( self.backgroundContext! )
    }
    
    // call back function by saveContext, support multi-thread
    func contextDidSaveContext(notification: NSNotification) {
        let sender = notification.object as NSManagedObjectContext
        if sender === self.managedObjectContext {
            println("Saved main Context in this thread")
            self.backgroundContext!.performBlock {
                self.backgroundContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else if sender === self.backgroundContext {
            println("Saved background Context in this thread")
            self.managedObjectContext!.performBlock {
                self.managedObjectContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        } else {
            println("Saved Context in other thread")
            self.backgroundContext!.performBlock {
                self.backgroundContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
            self.managedObjectContext!.performBlock {
                self.managedObjectContext!.mergeChangesFromContextDidSaveNotification(notification)
            }
        }
    }
}