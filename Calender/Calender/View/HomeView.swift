//
//  HomeView.swift
//  Calender
//
//  Created by Настя on 03/11/2021.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @State var currentDate: Date = Date()
    @State var openCreateTask: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                CustomCalender(currentDate: $currentDate)
                    .environmentObject(taskViewModel)
                
            }
            .padding(.vertical)
        }
        .safeAreaInset(edge: .bottom) {
            
            HStack {
                Button(action: {
                    openCreateTask.toggle()
                }, label:
                        {Text ("Добавить дело")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Blue2"), in: Capsule())}
                ).sheet(isPresented: $openCreateTask, content: {
                    CreateTask(date: Date(), timeStart: Date(), timeFinish: Date(), backButton: $openCreateTask, textFilder: "", textEdit: "", isEdit: true, index: "") .environmentObject(taskViewModel)
                })
                
                /*Button{
                    
                } label: {
                    Text ("Удалить дело")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(Color("Blue1"), in: Capsule())
                }*/
            }
            .padding(.horizontal)
            .padding(.top,10)
            .foregroundColor(.white)
            .background(.ultraThinMaterial)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
