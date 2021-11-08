//
//  CustomCalender.swift
//  Calender
//
//  Created by Настя on 03/11/2021.
// 7:29

import SwiftUI
//import XCTest

struct CustomCalender: View {
    @EnvironmentObject var taskViewModel: TaskViewModel
    @Binding var currentDate: Date
    
    @State private var openTaskDiscription: Bool = false
    @State var currentMonth: Int = 0
    var body: some View {
        VStack(spacing: 35) {
            
            //строка с днями недели
            let days: [String] = ["ВС", "ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ"]
            
            HStack(spacing: 20) {
                
                VStack(alignment: .center, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    HStack(spacing: 10){
                        Spacer()
                        Button {
                            withAnimation{
                                currentMonth -= 1
                            }
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.title)
                        }
                        Text(extraDate()[1])
                            .font(.title.bold())
                        
                        Button {
                            withAnimation{
                                currentMonth += 1
                            }
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title)
                        }
                        Spacer()
                    }
                }
                
                
                
                
            }
            .padding(.horizontal)
            
            // отрисовка дней
            HStack(spacing: 0){
                ForEach(days,id: \.self){day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // отрисовка чисел
            
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                
                ForEach(extractDate()){value in
                    CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("Blue1"))
                                .padding(.horizontal,8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                        }
                }
            }
            
            
            VStack(spacing: 15){
                Text("Дела")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 20)
                if let task = taskViewModel.tasks.first(where: {task in
                    return isSameDay(date1: task.taskDate, date2: currentDate)
                }){
                    
                    ForEach(task.task){task in
                      
                        Button(action: {
                            openTaskDiscription.toggle()
                        }, label:{
                            VStack(alignment: .leading, spacing: 10){
                                HStack{
                                    Text(task.timeStart!)
                                    Text("-")
                                    Text(task.timeFinish!)
                                }
                                Text(task.title)
                                    .font(.title2.bold())
                                
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                    Color("Blue2")
                                        .opacity(0.5)
                                        .cornerRadius(10)
                                    
                                )
                        }
                        ).sheet(isPresented: $openTaskDiscription, content: {
                            CreateTask(date: task.date, timeStart: Date(), timeFinish: Date(), backButton: $openTaskDiscription, textFilder: task.title, textEdit: task.description, isEdit: false, index: task.id) .environmentObject(taskViewModel)
                        })
                   
                    }
                    
                }
                else{
                    Text("Нет дел")
                }
            }
            .padding()
        }
        .onChange(of: currentMonth) { newValue in
            //updating month
            currentDate = getCurrentMonth()
        }
        .onAppear{
            //taskViewModel.onStart()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)-> some View{
        //problem!!!!
        VStack {
            if value.day != -1{
                if let task = taskViewModel.tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }){
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : Color("Blue1"))
                        .frame(width: 8, height: 8)
                }
                else{
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    //checking dates
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{
            return Date()
        }
        return currentMonth
    }
    
    func extractDate()->[DateValue]{
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
            
        }
        
        //adding ofset days to get exact week day
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    
}

struct CustomCalender_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
