//
//  DayMoneyApp.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/24.
//

import SwiftUI

@main
struct DayMoneyApp: App {
    init() {
        print(MoneyStore().오늘날)
        print(MoneyStore().앱을켰을때day)
        print(UserDefaults.standard.bool(forKey: "첫번째1일인가"))
        print("전체돈 : \(UserDefaults.standard.integer(forKey: "총금액"))")
        // 초기 day 저장, 날이 변했을때 오늘 사용가능한 돈 업데이트 로직
        if MoneyStore().앱을켰을때day == "저장안됨" {
            print("처음사용자입니다.")
            UserDefaults.standard.set(MoneyStore().오늘날, forKey: "앱을켰을때day")
            UserDefaults.standard.set(MoneyStore().money / (Int(MoneyStore().이달의마지막일)! - Int(MoneyStore().오늘날)! + 1), forKey: "오늘사용가능한돈")
            MoneyStore().todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
            
        } else if MoneyStore().앱을켰을때day != MoneyStore().오늘날 { // 다음날로 넘어갔을때 로직
            if MoneyStore().오늘날 == "1" {
                if MoneyStore().앱을켰을때day != "1" {
                    UserDefaults.standard.set(true, forKey: "첫번째1일인가")
                }
            }
            print("날이바뀜 이닛")
            UserDefaults.standard.set(MoneyStore().오늘날, forKey: "앱을켰을때day")
            UserDefaults.standard.set(MoneyStore().money / (Int(MoneyStore().이달의마지막일)! - Int(MoneyStore().오늘날)! + 1), forKey: "오늘사용가능한돈")
            MoneyStore().todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
            
            UserDefaults.standard.set(nil, forKey: "사용한돈")
            UserDefaults.standard.set(nil, forKey: "사용내역")
            MoneyStore().spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
            MoneyStore().spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
            print("update 완료")
        }
//            Thread.sleep(forTimeInterval: 1)
    }
    
    var body: some Scene {
        WindowGroup {
                DaySpentView()
                    .environmentObject(MoneyStore())
        }
    }
}
