//
//  AddReceiptView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct AddReceiptView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    @State private var money = ""
    @State private var content = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("사용한 돈을 입력해주세요.", text: $money)
            
            TextField("사용 내역을 입력해주세요.", text: $content)
            
            Button {
                print("추가")
                UserDefaults.standard.set(moneyStore.money - (Int(money) ?? 0), forKey: "총금액")
                moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                
                UserDefaults.standard.set(moneyStore.todayMoney - (Int(money) ?? 0), forKey: "오늘사용가능한돈")
                moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
                
                var tempMoneyArr: [String] = moneyStore.spendMoneyHistory
                tempMoneyArr.append(money)
                UserDefaults.standard.set(tempMoneyArr, forKey: "사용한돈")
                moneyStore.spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
                
                var tempContentArr: [String] = moneyStore.spendContentsHistory
                tempContentArr.append(content)
                UserDefaults.standard.set(tempContentArr, forKey: "사용내역")
                moneyStore.spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
                dismiss()
            } label: {
                Text("추가하기")
            }
        }
        .padding()
        .onAppear {
            print(moneyStore.todayMoney)
            print(UserDefaults.standard.integer(forKey: "오늘사용가능한돈"))
            print(moneyStore.spendMoneyHistory)
            print(moneyStore.spendContentsHistory)
        }
    }
}

struct AddReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        AddReceiptView()
    }
}
