//
//  MoneyStore.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import Foundation

class MoneyStore: ObservableObject {
    @Published var money: Int = UserDefaults.standard.integer(forKey: "총금액")
    @Published var spendMoneyHistory: [String] = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
    @Published var spendContentsHistory: [String] = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
}
