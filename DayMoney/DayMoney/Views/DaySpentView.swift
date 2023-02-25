//
//  DaySpentView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct DaySpentView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    
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
                
                Text("\(moneyStore.money)")
                Spacer()
                
                List(Array(zip(moneyStore.spendMoneyHistory, moneyStore.spendContentsHistory)), id: \.self.0) { (money, content) in
                    Text("-\(money) \(content)")
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
