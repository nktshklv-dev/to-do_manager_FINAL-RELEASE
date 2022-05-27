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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

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
