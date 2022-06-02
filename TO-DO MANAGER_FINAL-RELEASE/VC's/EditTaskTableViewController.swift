//
//  EditTaskTableViewController.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import UIKit

class EditTaskTableViewController: UITableViewController {
    
    var taskText: String = ""
    var taskType: TaskPriority = .important
    var taskStatus: TaskStatus = .planned
    
    var doAfterSaving: (( String,  TaskPriority,  TaskStatus) -> Void)?
    
    
    @IBOutlet var taskNameField: UITextField!
    @IBOutlet var taskTypeLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    var taskTypeAndString: [TaskPriority: String] = [.important: "Important", .general: "General"]

    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameField.text = taskText
        taskTypeLabel.text = taskTypeAndString[taskType]
            
        if taskStatus == .finished{
            taskStatusSwitch.isOn = true
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    @IBAction func saveTaskButton(_ sender: Any) {
        taskText = taskNameField.text ?? ""
        taskType = (taskTypeLabel.text == "Important") ? .important : .general
        taskStatus = taskStatusSwitch.isOn ? .finished : .planned
        doAfterSaving!(taskText, taskType, taskStatus)
        
        navigationController?.popViewController(animated: true)
        
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromEditToSelectType"{
            let currentVC = segue.destination as! SelectTypeController
            currentVC.selectedType = taskType
            currentVC.doAfterSelectedType = {
                type in self.taskType = type
                self.taskTypeLabel.text = (type == .important) ? "Important" : "General"
            }
          
            
        }
    }
}
