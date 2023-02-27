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
    }
    
    var body: some View {
        VStack {
            Text(date, formatter: dateFormatter) // "January 14, 2021 at 10:00 AM"
            Text(Date(), style: .time)
            Text(Date(), style: .date)
            Text(Date(), style: .offset)
            Text(Date(), style: .relative)
            Text(Date(), style: .timer)
            Text("\(Date())")
        }
    }
}

struct CurrentTimeTestView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTimeTestView()
    }
}
