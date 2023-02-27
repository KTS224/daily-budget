//
//  HistoryView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/27.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var moneyStore: MoneyStore
    
    var body: some View {
        List(Array(zip(moneyStore.moneyHistory, moneyStore.contentHistory).enumerated()).reversed(), id: \.offset) { index, element in
            HStack {
                Text("-\(element.0) ₩ ")
                Spacer()
                Text(element.1)
            }
        }
        .listStyle(.inset)
        .navigationTitle("이전 사용 내역")
        .onAppear {
            print(Array(zip(moneyStore.moneyHistory, moneyStore.contentHistory).enumerated()))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
