//
//  DayMoneyApp.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/24.
//

import SwiftUI

@main
struct DayMoneyApp: App {
    var body: some Scene {
        WindowGroup {
            if (UserDefaults.standard.integer(forKey: "총금액")) < 1 {
                MoneySettingView()
                    .environmentObject(MoneyStore())
            } else {
                DaySpentView()
                    .environmentObject(MoneyStore())
            }
        }
    }
}
