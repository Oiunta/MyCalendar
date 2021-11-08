//
//  CalenderApp.swift
//  Calender
//
//  Created by Настя on 03/11/2021.
//

import SwiftUI

@main
struct CalenderApp: App {
    @StateObject var taskViewModel = TaskViewModel()
    var body: some Scene {
        WindowGroup {
            VStack{
                HomeView()
                    .environmentObject(taskViewModel)
            }
        }
    }
}
