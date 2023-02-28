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
        print("전체돈 : \(UserDefaults.standard.integer(forKey: "총금액"))")
        // 초기 day 저장, 날이 변했을때 오늘 사용가능한 돈 업데이트 로직
        if MoneyStore().앱을켰을때day == "저장안됨" {
//            UserDefaults.standard.set(MoneyStore().오늘날, forKey: "앱을켰을때day")
//            UserDefaults.standard.set(MoneyStore().money / (Int(MoneyStore().이달의마지막일)! - Int(MoneyStore().오늘날)! + 1), forKey: "오늘사용가능한돈")
//            MoneyStore().todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
//            print("저장완료")
        } else if MoneyStore().앱을켰을때day != MoneyStore().오늘날 { // 다음날로 넘어갔을때 로직
            print("날이바뀜")
//            UserDefaults.standard.set(MoneyStore().오늘날, forKey: "앱을켰을때day")
//            UserDefaults.standard.set(MoneyStore().money / (Int(MoneyStore().이달의마지막일)! - Int(MoneyStore().오늘날)! + 1), forKey: "오늘사용가능한돈")
//            MoneyStore().todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
            
            UserDefaults.standard.set(nil, forKey: "사용한돈")
            UserDefaults.standard.set(nil, forKey: "사용내역")
            MoneyStore().spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
            MoneyStore().spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
            print("update 완료")
        }
            Thread.sleep(forTimeInterval: 1)
    }
    
    var body: some Scene {
        WindowGroup {
                DaySpentView()
                    .environmentObject(MoneyStore())
        }
    }
}
