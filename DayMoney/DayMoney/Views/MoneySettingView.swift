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
            Text("이번 달 사용할 목표 금액이 얼마인가요?")
                .bold()
                .font(.system(size: 20))
            HStack {
                TextField("10000", text: $money.value)
                    .padding(10)
                    .border(Color.black.opacity(0.3))
                    .keyboardType(.decimalPad)
                Spacer()
                Text("원")
            }
            .padding(.vertical, 30)
            .padding(.horizontal, 110)
            
            Button {
                if !isShowingOnboardingView {
                    self.isShowingAlert = true
                } else {
                    UserDefaults.standard.set(Int(money.value), forKey: "총금액")
                    moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")
                    UserDefaults.standard.set(false, forKey: "isShowingOnboardingView")
                    UserDefaults.standard.set(false, forKey: "첫번째1일인가")
                    print(UserDefaults.standard.bool(forKey: "첫번째1일인가"))
                    isShowingOnboardingView = false
                    dismiss()
                }
            } label: {
                Text("설정하기")
                    .foregroundColor(money.value == "" || money.value.prefix(1) == "0" ? .secondary : .black)
                    .font(.system(size: 20))
                    .frame(width: UIScreen.main.bounds.width - 60, height: 48)
                    .background(money.value == "" || money.value.prefix(1) == "0" ? Color.gray : Color.orange)
                    .cornerRadius(10)
            }
            .disabled(money.value == "" || money.value.prefix(1) == "0")
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
