//
//  Task.swift
//  TO-DO MANAGER_FINAL-RELEASE
//
//  Created by Nikita  on 5/27/22.
//

import Foundation

enum TaskStatus: Int{
    case planned = 1
    case finished = 0
}
enum TaskPriority{
    case general
    case important
}

protocol TaskProtocol{
    var taskTitle: String {get set}
    var taskStatus: TaskStatus {get set}
    var taskPriority: TaskPriority {get set}
}


struct Task: TaskProtocol{
    var taskTitle: String
    
    var taskStatus: TaskStatus
    
    var taskPriority: TaskPriority
}
