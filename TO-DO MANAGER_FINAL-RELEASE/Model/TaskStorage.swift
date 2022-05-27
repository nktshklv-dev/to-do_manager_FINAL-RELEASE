//
//  TaskStorage.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import Foundation


protocol TaskStorageProtocol{
    static func saveTasks(_ tasks: [TaskProtocol])
    
    static func loadTasks() -> [TaskProtocol]
}


class TaskStorage: TaskStorageProtocol{
    static func saveTasks(_ tasks: [TaskProtocol]) {
        print("")
    }
    
    static func loadTasks() -> [TaskProtocol] {
        let tasks = [Task(taskTitle: "first task", taskStatus: .planned, taskPriority: .important), Task(taskTitle: "second task", taskStatus: .finished, taskPriority: .important), Task(taskTitle: "third task", taskStatus: .planned, taskPriority: .general), Task(taskTitle: "fourth task", taskStatus: .finished, taskPriority: .general)]
        
        return tasks
    }
    
    
}
