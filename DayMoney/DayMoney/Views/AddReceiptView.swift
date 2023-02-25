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
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            TextField("사용한 돈을 입력해주세요.", text: $money)
            
            Button {
                print("추가")
                UserDefaults.standard.set(moneyStore.money - (Int(money) ?? 0), forKey: "총금액")
                moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                dismiss()
            } label: {
                Text("추가하기")
            }
        }
        .padding()
    }
}

struct AddReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        AddReceiptView()
    }
}
