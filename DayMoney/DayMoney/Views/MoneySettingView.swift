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
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("용돈을 입력해 주세요.", text: $money.value)
                
                Button {
                    UserDefaults.standard.set(Int(money.value), forKey: "총금액")
                    moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                    UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
                    isShowingOnboardingView = false
                    dismiss()
                } label: {
                    Text("변경하기")
                }
                .disabled(money.value == "")
            }
            .padding()
        }
    }
}

struct MoneySettingView_Previews: PreviewProvider {
    static var previews: some View {
        MoneySettingView(isShowingOnboardingView: .constant(true))
    }
}
