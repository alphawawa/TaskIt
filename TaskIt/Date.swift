//
//  Date.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/27/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import Foundation

class Date {
    
    
    // the # sound is like a label to help populate the arguments when it pops up in other places in the code.  Also, NSDate opject is from Cocoa - apparently Swift doesn't have this object yet.
    class func from (#year:Int, month: Int, day: Int) -> NSDate {
        
        var components = NSDateComponents()
        
        // update the properties according to the parameters (arguments) of this function.
        components.year = year
        components.month = month
        components.day = day

        // create a Calendar instance
        var gregorianCalendar = NSCalendar(identifier: NSGregorianCalendar)
        // create a date instance from a NSCalendar function using "components" as an argument.  The function returns an optional (?), thus the unwrapping (!) when date is returned.
        var date = gregorianCalendar?.dateFromComponents(components)

        return date!
    }
    
    class func toString(#date:NSDate) -> String {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateStringFormatter.stringFromDate(date)
        
        
        return dateString
    }
    
    
    
}