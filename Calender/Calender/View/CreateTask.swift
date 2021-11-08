//
//  CreateTask.swift
//  Calender
//
//  Created by Настя on 07/11/2021.
//

import SwiftUI

struct CreateTask: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    
    @State var date: Date
    @State var timeStart: Date
    @State var timeFinish: Date
    @Binding var backButton: Bool
    @State var textFilder: String
    @State var textEdit: String
    @State var isEdit: Bool
    @State var index: String
    
    var body: some View {
        VStack(alignment: .center){
            if isEdit {
                Text("Добавить дело")
                    .foregroundColor(.blue)
                    .bold()
                    .padding()
            } else {
                Text("Просмотр дела")
                    .foregroundColor(.blue)
                    .bold()
                    .padding()
            }
                
            
            List{
                HStack(spacing: 0){
                    TextField("Название",text: $textFilder)
                        .foregroundColor(.black)
                    Spacer()
                }
                HStack(spacing: 0){
                    DatePicker("Дата", selection: $date, in: Date()..., displayedComponents: [.date])
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                }.foregroundColor(.black)
                HStack(spacing: 5){
                    DatePicker("Время C", selection: $timeStart, in: Date()..., displayedComponents: [.hourAndMinute])
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                    DatePicker("По", selection: $timeFinish, in: timeStart..., displayedComponents: [.hourAndMinute])
                        .environment(\.locale, Locale.init(identifier: "ru_RU"))
                }.foregroundColor(.black)
                HStack {
                    Text ("Описание")
                    Spacer()
                }.foregroundColor(.black)
                HStack {
                    TextEditor(text: $textEdit)
                        .frame(height: 100)
                    Spacer()
                }.foregroundColor(.black)
            
                HStack(){
                    Spacer()
                    if isEdit {
                        Button(action: {
                            self.taskViewModel.createTask(taskDate: date,
                                                          title: textFilder,
                                                          description: textEdit,
                                                          timeStart: timeStart,
                                                          timeFinish: timeFinish)
                            backButton.toggle()
                            

                            
                        }, label: {
                            Text("Добавить")
                                .foregroundColor(.blue)
                                .bold()
                            
                        })
                    } else {
                        Button(action: {
                            self.taskViewModel.removeTask(index: index)
                            backButton.toggle()
                            
                        }, label: {
                            Text("Удалить")
                                .foregroundColor(.red)
                        })
                    }
                    Spacer()
                }
            }

        }
    }
}

/*struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        //CreateTask(backButton: .constant(false), isEdit: true)
    }
}*/

