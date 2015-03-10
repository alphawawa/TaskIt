//
//  ViewController.swift
//  TaskIt
//
//  Created by Rob Passaro on 1/26/15.
//  Copyright (c) 2015 Rob Passaro. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    // InterfaceBuilder outlets
    @IBOutlet weak var tableView: UITableView!
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    // "an optimized way of managing our table view"
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    // called by the OS once view...loads.  Duh.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        fetchedResultsController  = getFetchResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
            let thisTask = fetchedResultsController.objectAtIndexPath(indexPath!) as TaskModel
            
            // how does one change the value of a *constant* here?  I don't understand.  Either way, set the detailTaskModel of this...delegate?...of the TaskDetailViewController to the currently selected task.
            detailVC.detailTaskModel = thisTask
        }
        else
        if segue.identifier == "showTaskAdd" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
        
    }
    

    // UITableViewDataSource functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // tells us how many rows we should have
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        println(indexPath.row)
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
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
        
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            
            thisTask.completed = true
            
        } else {
            
            thisTask.completed = false
        }

        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    
    // Helpers
    
    // this will automatically return all of our entities sorted by date
    func taskFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        fetchedResultsController  = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchedResultsController
    }
    
    
    
}

