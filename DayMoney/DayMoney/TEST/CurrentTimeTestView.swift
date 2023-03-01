//
//  CurrentTimeTestView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/27.
//

import SwiftUI

struct CurrentTimeTestView: View {
    let date: Date
    let dateFormatter: DateFormatter
    
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "d"
    }
    
    var body: some View {
        VStack {
            Group {
                Text(date, formatter: dateFormatter) // "January 14, 2021 at 10:00 AM"
                Text(Date(), style: .time)
                Text(Date(), style: .date)
                Text(Date(), style: .offset)
                Text(Date(), style: .relative)
                Text(Date(), style: .timer)
                Text("\(Date())")
            }
            Spacer()
            Group {
                Text(Date().startOfMonth(), style: .date) // 현재 달의 첫번째 날
                Text(Date().endOfMonth()-1, style: .date) // 현재 달의 마지막 날
                
                Text(dateFormatter.string(from: Date().endOfMonth()-1)) // 이번달의 마지막날
                Text(dateFormatter.string(from: Date())) // 현재 날
            }
        }
    }
}
