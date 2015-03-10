//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/27/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    // property that allows us to pass *the* instance of ViewController to this AddTaskViewController (how the hell does it do that?)
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addTaskButtonTapped(sender: UIButton) {
 
        // this gives us "access" to an instance of our AppDelegate.  UIApplication represents our entire application.
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        // now we can manage our "managedObject Context
        let managedObjectContext = appDelegate.managedObjectContext
        
        // ??
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        // create our task instance
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        task.task = taskTextField.text
        task.subtask = subtaskTextField.text
        task.date = dueDatePicker.date
        task.completed = false
        
        // this saves any changes to our entity, thus far.  Anything after this is not saved.
        appDelegate.saveContext()
        
        // "How do we get back all the entities that we created?"
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        // "we have to unwrap this because there is a chance it could be nil."  Not an explanation, BitFountain
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
