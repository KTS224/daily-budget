//
//  MoneyStore.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import Foundation

class MoneyStore: ObservableObject {
    @Published var money: Int = UserDefaults.standard.integer(forKey: "총금액")
}
