//
//  AddReceiptView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct AddReceiptView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    @ObservedObject var money = NumbersOnly()
    @State private var content = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("무엇을 사는데 얼마를 사용하셨나요?")
                .bold()
                .font(.system(size: 20))
                .padding(.bottom, 80)
            
            HStack {
                TextField(" 1000", text: $money.value)
                    .border(Color.black.opacity(0.3))
                    .keyboardType(.decimalPad)
                    .frame(width: 100)
                Text("원")
                Spacer()
            }
            
            TextField("길가다가 붕어빵 사먹었다.", text: $content)
                .frame(height: 100)
                .padding(10)
                .border(Color.black.opacity(0.3))
            
            Button {
                print("추가")
                UserDefaults.standard.set(moneyStore.money - (Int(money.value) ?? 0), forKey: "총금액")
                moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                
                UserDefaults.standard.set(moneyStore.todayMoney - (Int(money.value) ?? 0), forKey: "오늘사용가능한돈")
                moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
                
                var tempMoneyArr: [String] = moneyStore.spendMoneyHistory
                tempMoneyArr.append(money.value)
                UserDefaults.standard.set(tempMoneyArr, forKey: "사용한돈")
                moneyStore.spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
                
                var tempContentArr: [String] = moneyStore.spendContentsHistory
                tempContentArr.append(content)
                UserDefaults.standard.set(tempContentArr, forKey: "사용내역")
                moneyStore.spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
                
                var tempMoneyHistory = moneyStore.moneyHistory
                tempMoneyHistory.append(money.value)
                UserDefaults.standard.set(tempMoneyHistory, forKey: "돈히스토리")
                moneyStore.moneyHistory = UserDefaults.standard.array(forKey: "돈히스토리") as? [String] ?? []
                
                var tempContentHistory = moneyStore.contentHistory
                tempContentHistory.append(content)
                UserDefaults.standard.set(tempContentHistory, forKey: "내역히스토리")
                moneyStore.contentHistory = UserDefaults.standard.array(forKey: "내역히스토리") as? [String] ?? []
                
                dismiss()
            } label: {
                Text("추가하기")
                    .foregroundColor(money.value == "" || content == "" || money.value.prefix(1) == "0" ? .secondary : .black)
                    .font(.system(size: 20))
                    .frame(width: UIScreen.main.bounds.width - 30, height: 48)
                    .background(money.value == "" || content == "" || money.value.prefix(1) == "0" ? Color.gray : Color.orange)
                    .cornerRadius(10)
                    .padding()
            }
            .disabled(money.value == "" || content == "" || money.value.prefix(1) == "0")
        }
        .padding()
        .onAppear {
            print(moneyStore.todayMoney)
            print(UserDefaults.standard.integer(forKey: "오늘사용가능한돈"))
            print(moneyStore.spendMoneyHistory)
            print(moneyStore.spendContentsHistory)
        }
        .onDisappear {
            print(moneyStore.spendContentsHistory)
        }
        .navigationTitle("사용 내역 추가")
    }
}

struct AddReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        AddReceiptView()
            .environmentObject(MoneyStore())
    }
}
