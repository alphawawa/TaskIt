//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/26/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    // this variable allows us to pass the name of the task tapped to the newly created Task Detail viewcontroller.  However, when does that info get passed to this variable?
    var detailTaskModel: TaskModel!
    
    // these are the UI elements of the Task Detail screen

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    // Here's where you put the magic for this class creation
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // these set the text fields or UI elements of the new view with the data from the cell that was clicked
        // ex: if one taps on the cell with "Eat Dinner" the new detailed view shows "Eat Dinner" in its text field (to be edited or whatever).  It's all about passing data between objects/views.
        
        self.taskTextField.text = detailTaskModel.task
        self.subtaskTextField.text = detailTaskModel.subtask
        self.dueDatePicker.date = detailTaskModel.date

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        
        // update each of the elements with the text fields and data from date picker
        detailTaskModel.task = taskTextField.text
        detailTaskModel.subtask = subtaskTextField.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        // save to CoreData
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
