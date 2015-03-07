//
//  ViewController.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/26/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // InterfaceBuilder outlets
    @IBOutlet weak var tableView: UITableView!
    
    // an array of type TaskModel (which is a struct we defined), intialized to empty set
//    var taskArray:[TaskModel] = []
    var baseArray:[[TaskModel]] = []
    
    // called by the OS once view...loads.  Duh.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // populate the NSDate instances with data
        let date1 = Date.from(year: 2014, month: 05, day: 20)
        let date2 = Date.from(year: 2014, month: 03, day: 3)
        let date3 = Date.from(year: 2014, month: 12, day: 13)
        
        // provide the task entries for this task app by specifying three TaskModel structs
        let task1 = TaskModel(task: "Study French", subtask: "verbs", date: date1, completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subtask: "burgers", date: date2, completed: false)
        let taskArray = [task1, task2, TaskModel(task: "Gym", subtask: "leg day", date: date3, completed: false)]
        var completedArray = [TaskModel(task: "code", subtask: "task project", date: date2, completed: true)]
        // array containing incomplete and complete tasks
        baseArray = [taskArray, completedArray]
        
        // I think this pattern is the same as "refresh labels" used in previous projects.  This will be called after state variables are changed so that the view reflects that new state.
        self.tableView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

//        // example of an "embedded" function, which is not good practice according to BitFountain
//        func sortByDate (taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        //
//        taskArray = taskArray.sorted(sortByDate)
        
        // this is the "closure" syntax of the above commented-out code, I think.
        baseArray[0] = baseArray[0].sorted{
            
            // here are the arguments and the return type
            (taskOne:TaskModel, taskTwo:TaskModel) -> Bool in
            
            // comparison logic here
            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
        }
        
        // refreshes all the elements of the UITableView, and redraws appropriately.
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // we explicitly wrote this override function so we could do things before new viewcontrollers appear (says bitfountain)
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // use this control flow to determine which screen will be built next, and then do some things before the screen is built.  This is all in the context of keeping memory usage minimal, as expected for mobile usage.
        if segue.identifier == "showTaskDetail" {
            
            // this constant of type TaskDetailViewController lets us access the forthcoming viewcontroller, as "reported" by the read-only destinationViewController
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController

            // get index of current user-selected tableView element
            let indexPath = self.tableView.indexPathForSelectedRow()

            // retrieve the task from taskArray corresponding to the selected tableView element
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            
            // how does one change the value of a *constant* here?  I don't understand.  Either way, set the detailTaskModel of this...delegate?...of the TaskDetailViewController to the currently selected task.
            detailVC.detailTaskModel = thisTask
            
            // I don't understand this statement.  Maybe this is where the data contents of the other views are transferred to the other ViewController.  Actually, that makes sense.  Create a copy of this classes data for the class we are going to.  So, how does it get back here?
            detailVC.mainVC = self
        }
        else
        if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            // copy all data from this class TO the property of the class we are "going to"
            addTaskVC.mainVC = self
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
    }
    

    // UITableViewDataSource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return baseArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // tells us how many rows we should have
        return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        
        // declare a contast that is equal to the indexed element of the class property taskArray
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        // declare a variable of type TaskCell and set it equal to...whatever cell is retrieved from the tableView?
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        
        // set the text properties of the current cell equal to the equivalent elements of the array that contains the user data (ex: "Study French")
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subtask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        return cell
    }
    
    // UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // print out what cell we are tapping
        println(indexPath.row)
        
        // make our segue occur to show our Task Detail ViewController
        performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    // sets the height for our header in each section to be 25 points
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    // adds headers with text to each section
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        } else {
            return "Completed"
        }
    }
    
    // allows us to swipe and determine what happens when swiped
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: true)
            
            // add task to the OTHER array (the completed tasks)
            baseArray[1].append(newTask)
            
        } else {
            
            var newTask = TaskModel(task: thisTask.task, subtask: thisTask.subtask, date: thisTask.date, completed: false)
            baseArray[0].append(newTask)
            
        }
        
        // remove task that was swiped
        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        
        // refresh all the info in the tableView
        tableView.reloadData()
    }
    
    // Helpers
    
    
}

