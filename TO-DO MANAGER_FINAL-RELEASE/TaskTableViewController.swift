//
//  TaskTableViewController.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var tasks: [TaskPriority: [TaskProtocol]] = [:]{
        didSet{
            for (taskPriority, tasksGroup) in tasks{
                tasks[taskPriority] = tasksGroup.sorted{
                    task1, task2 in task1.taskStatus.rawValue > task2.taskStatus.rawValue
                }
            }
        }
    }
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
    

 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let type = taskPriorityForSection[indexPath.section]
        tasks[type]?.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .fade)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = taskPriorityForSection[indexPath.section]
        
        guard let _ = tasks[type]?[indexPath.row] else{
            return
        }
        
        guard tasks[type]![indexPath.row].taskStatus == .planned else{
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        tasks[type]![indexPath.row].taskStatus = .finished
        tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
    }
    
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let type = taskPriorityForSection[indexPath.section]
        guard let _ = tasks[type]?[indexPath.row] else{
            return nil
        }
        
        guard tasks[type]![indexPath.row].taskStatus == .finished else{
            return nil
        }
        
        let action = UIContextualAction(style: .normal, title: "Plan", handler:{
            _,_,_ in self.tasks[type]![indexPath.row].taskStatus = .planned
            self.tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
        })
        action.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [action])
    }
    

    
  

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let taskTypeFrom = taskPriorityForSection[sourceIndexPath.section]
        let taskTypeTo = taskPriorityForSection[destinationIndexPath.section]
        
        guard let currentTask = tasks[taskTypeFrom]?[sourceIndexPath.row] else{
            return
        }
        
        tasks[taskTypeFrom]?.remove(at: sourceIndexPath.row)
        tasks[taskTypeTo]?.insert(currentTask, at: destinationIndexPath.row)
        
        if taskTypeTo != taskTypeFrom {
            tasks[taskTypeTo]![destinationIndexPath.row].taskPriority = taskTypeTo
        }
        
        tableView.reloadData()
    }

}
