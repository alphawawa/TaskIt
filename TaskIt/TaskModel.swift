//
//  TaskModel.swift
//  TaskIt
//
//  Created by Rob Passaro on 3/7/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
