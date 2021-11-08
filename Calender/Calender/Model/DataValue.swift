//
//  DataValue.swift
//  Calender
//
//  Created by Настя on 03/11/2021.
//

import SwiftUI

struct DateValue: Identifiable {
    var id = UUID().uuidString //автоматически присваивает id в формате стринг
    var day: Int
    var date: Date
}
