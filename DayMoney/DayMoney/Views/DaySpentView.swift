//
//  DaySpentView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct DaySpentView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    // TODO: 변수명 수정 예정, (쓸수있는돈, 날짜, 총 금액) 표시 예정
    @State private var currentTitleDisplay = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    NavigationLink {
                        AddReceiptView()
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Spacer()
                    
                    // TODO: CalendarView 구현 예정
                    //                Button {
                    //                    print("달력")
                    //                } label: {
                    //                    Image(systemName: "calendar")
                    //                }
                    
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                
                Text(currentTitleDisplay ? "\(Date(), style: .date)" : "\(moneyStore.money) ₩")
                    .font(.headline)
                    .monospaced()
                    .onTapGesture {
                        currentTitleDisplay.toggle()
                    }
                Spacer()
                
                List(Array(zip(moneyStore.spendMoneyHistory, moneyStore.spendContentsHistory)), id: \.self.0) { (money, content) in
                    HStack {
                        Text("-\(money) ₩ ")
                        Spacer()
                        Text("\(content)")
                    }
                }
            }
            .padding()
        }
        .onAppear {
            print("데이 스펜트 뷰 온어피어")
        }
    }
}

struct DaySpentView_Previews: PreviewProvider {
    static var previews: some View {
        DaySpentView()
            .environmentObject(MoneyStore())
    }
}
