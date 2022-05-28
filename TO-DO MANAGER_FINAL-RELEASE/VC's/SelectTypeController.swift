//
//  SelectTypeController.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import UIKit

class SelectTypeController: UITableViewController {
    
    typealias DescriptionType = (type: TaskPriority, title: String, description: String)
    
    var descriptions: [DescriptionType] = [(type: .important, title: "Important", description: "This type is much more relevant for urgent tasks. Tasks of this type are located at the top section. "), (type: .general, title: "General", description: "General type is more suitable for non - urgent tasks. Tasks of this type are located above the important section. ")]
    var selectedType: TaskPriority = .important
    
    var doAfterSelectedType: ((TaskPriority) -> Void)?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "CellWithTypeDescription", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell2")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return descriptions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CellWithTypeDescription
        let currentDescription = descriptions[indexPath.row]
        cell.taskTypeName.text = currentDescription.title
        cell.taskTypeDescription.text = currentDescription.description
        
        if currentDescription.type == selectedType{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = descriptions[indexPath.row].type
        doAfterSelectedType!(selectedType)
        navigationController?.popViewController(animated: true)
        
        
    }
    

  
}
