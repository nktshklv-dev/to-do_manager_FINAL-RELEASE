//
//  TaskTableViewController.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var tasks: [TaskPriority: [TaskProtocol]] = [:]
    var taskStorage = TaskStorage()
    var taskPriorityForSection: [TaskPriority] = [.important, .general]

    override func viewDidLoad() {
        super.viewDidLoad()
        initTasks()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func initTasks(){
        taskPriorityForSection.forEach{
            type in tasks[type] = []
        }
        taskStorage.loadTasks().forEach{
            task in tasks[task.taskPriority]?.append(task)
        }
        
    }

  

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tasks.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let taskType = taskPriorityForSection[section]
        guard let tasksInSection = tasks[taskType] else{
            return 0
        }
       
        return tasksInSection.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        let taskType = taskPriorityForSection[indexPath.section]
        guard let currentTask = tasks[taskType]?[indexPath.row] else{
            return cell
        }
        
        cell.taskTitle.text = currentTask.taskTitle
        cell.taskIcon.text = getIconForStatus(currentTask.taskStatus)
        
        if currentTask.taskStatus == .planned{
            cell.taskTitle.textColor = .black
            cell.taskTitle.textColor = .black
        }
        else if currentTask.taskStatus == .finished{
            cell.taskTitle.textColor = .lightGray
        }
        return cell
        
        
    }
    
    func getIconForStatus(_ status: TaskStatus) -> String{
        var returnString = " "
        if status == .planned{
            returnString = "\u{25CB}"
        }
        else{
            returnString = "\u{25C9}"
        }
        return returnString
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = taskPriorityForSection[section]
        var text: String = ""
        
        if sectionType == .important{
            text = "Important"
        }
        else if sectionType == .general{
            text = "General"
        }
        return text
    }
    

 

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
