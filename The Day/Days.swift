//
//  Days.swift
//  The Day
//
//  Created by Hanul Park on 9/16/14.
//  Copyright (c) 2014 emstudio. All rights reserved.
//

import Foundation
import CoreData

@objc(Days)
class Days: NSManagedObject {

    @NSManaged var alias: String
    @NSManaged var countType: String
    @NSManaged var createdAt: NSDate
    @NSManaged var startDate: NSDate
    @NSManaged var favorite: Bool

}
