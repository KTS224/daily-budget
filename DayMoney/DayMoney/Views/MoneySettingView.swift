//
//  MoneySettingView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/24.
//

import SwiftUI

struct MoneySettingView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    @ObservedObject var money = NumbersOnly()
    @Binding var isShowingOnboardingView: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingAlert = false
    
    var body: some View {
        VStack {
            TextField("용돈을 입력해 주세요.", text: $money.value)
            
            Button {
                if !isShowingOnboardingView {
                    self.isShowingAlert = true
                } else {
                    UserDefaults.standard.set(Int(money.value), forKey: "총금액")
                    moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                    UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
                    isShowingOnboardingView = false
                    dismiss()
                }
            } label: {
                Text("변경하기")
            }
            .disabled(money.value == "")
        }
        .padding()
        .alert("모든 기록이 사라집니다. 정말 돈을 변경하시겠습니까?", isPresented: $isShowingAlert) {
            Button("바꾼다", role: .destructive) {
                /// 모든 기록 초기화
                UserDefaults.standard.set([], forKey: "사용한돈")
                UserDefaults.standard.set([], forKey: "사용내역")
                UserDefaults.standard.set([], forKey: "돈히스토리")
                UserDefaults.standard.set([], forKey: "내역히스토리")
                
                moneyStore.spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
                moneyStore.spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
                moneyStore.moneyHistory = UserDefaults.standard.array(forKey: "돈히스토리") as? [String] ?? []
                moneyStore.contentHistory = UserDefaults.standard.array(forKey: "내역히스토리") as? [String] ?? []
                
                UserDefaults.standard.set(Int(money.value), forKey: "총금액")
                moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                dismiss()
            }
        }
        .onDisappear {
            /// 사용할 용돈을 변경했을경우 홈에 나오는 금액도 변경해주기 위한 로직
            UserDefaults.standard.set(moneyStore.money / (Int(moneyStore.이달의마지막일)! - Int(moneyStore.오늘날)! + 1), forKey: "오늘사용가능한돈")
            moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
        }
    }
}

struct MoneySettingView_Previews: PreviewProvider {
    static var previews: some View {
        MoneySettingView(isShowingOnboardingView: .constant(true))
    }
}
