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
    
    
    @IBOutlet var taskNameField: UITextField!
    @IBOutlet var taskTypeLabel: UILabel!
    @IBOutlet var taskStatusSwitch: UISwitch!
    
    var taskTypeAndString: [TaskPriority: String] = [.important: "Important", .general: "General"]

    override func viewDidLoad() {
        super.viewDidLoad()
        taskNameField.text = taskText
        taskTypeLabel.text = taskTypeAndString[taskType]
            
        if taskStatus == .planned{
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
}
