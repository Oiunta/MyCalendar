//
//  TaskViewModel.swift
//  Calender
//
//  Created by Настя on 07/11/2021.
//

import Foundation
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskMetaData] = []
    
    //sample date for testing
    func getSampleDate(offset: Int)-> Date{
        let calender = Calendar.current
        let date = calender.date(byAdding: .day, value: offset, to: Date())
        return date ?? Date()
    }
    
    func removeTask(index: String){
        
        if (tasks[0].task.count > 1) {
            for j in 0..<tasks[0].task.count{
                if tasks[0].task[j].id == index {
                    tasks[0].task.remove(at: j )
                    break
                }
            }
        } else {
            tasks.removeAll()
        }
    }
    
    func createTask(taskDate: Date, title: String, description: String, timeStart: Date, timeFinish: Date){
        
        if tasks.isEmpty {
            tasks.append(TaskMetaData(task: [Task(title: title, description: description, date: taskDate, timeStart: convertDate(time: timeStart), timeFinish: convertDate(time: timeFinish))], taskDate: taskDate))
        }else {
            tasks[0].task.append(Task(title: title, description: description, date: taskDate, timeStart: convertDate(time: timeStart), timeFinish: convertDate(time: timeFinish)))
        }
    }
    func convertDate(time: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: time)
        return dateString
    }
}
