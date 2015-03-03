//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/27/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    // property that allows us to pass *the* instance of ViewController to this AddTaskViewController (how the hell does it do that?)
    
    // this variable will give us access to the main task array.
    var mainVC: ViewController!
    
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
        
        // we create a new task with new parameters from the UI elements.
        var task = TaskModel(task: taskTextField.text, subtask: subtaskTextField.text, date: dueDatePicker.date)
        
        // now add this task to the task array of the view controller
        mainVC.taskArray.append(task)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
