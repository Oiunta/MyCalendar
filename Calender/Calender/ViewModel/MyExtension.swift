//
//  MyExtantion.swift
//  Calender
//
//  Created by Настя on 06/11/2021.
//

import Foundation

extension Date{
    
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        //получаем начальную дату
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        //получаем даты
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSince1970 - rhs.timeIntervalSince1970
        }
    
    var localizedDescription: String {
        return description(with: .current)
    }
}

