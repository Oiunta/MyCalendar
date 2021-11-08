//
//  Task.swift
//  Calender
//
//  Created by Настя on 06/11/2021.
//

import SwiftUI

//Task Model and Sample Tasks
//Array of Tasks
struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var description: String
    var time: Date = Date()
    var date: Date
    var timeStart: String?=nil
    var timeFinish: String?=nil
}

//Total task meeta view
struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

