//
//  MoneyStore.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import Foundation

class MoneyStore: ObservableObject {
    let date: Date
    let dateFormatter: DateFormatter
    
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "d"
    }
    
    @Published var moneyHistory: [String] = UserDefaults.standard.array(forKey: "돈히스토리") as? [String] ?? []
    @Published var contentHistory: [String] = UserDefaults.standard.array(forKey: "내역히스토리") as? [String] ?? []
    @Published var 앱을켰을때day: String = (UserDefaults.standard.string(forKey: "앱을켰을때day") ?? "저장안됨")
    @Published var money: Int = UserDefaults.standard.integer(forKey: "총금액")
    @Published var todayMoney: Int = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
    @Published var spendMoneyHistory: [String] = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
    @Published var spendContentsHistory: [String] = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
    lazy var 이달의마지막일 = dateFormatter.string(from: Date().endOfMonth()-1)
    lazy var 오늘날 = dateFormatter.string(from: Date())
}

extension Date {

func startOfMonth() -> Date {
    let interval = Calendar.current.dateInterval(of: .month, for: self)
    return (interval?.start.toLocalTime())! // Without toLocalTime it give last months last date
}

func endOfMonth() -> Date {
    let interval = Calendar.current.dateInterval(of: .month, for: self)
    return interval!.end
}

// Convert UTC (or GMT) to local time
func toLocalTime() -> Date {
    let timezone    = TimeZone.current
    let seconds     = TimeInterval(timezone.secondsFromGMT(for: self))
    return Date(timeInterval: seconds, since: self)
}}
