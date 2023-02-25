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
//                Text("\(UserDefaults.standard.integer(forKey: "총금액"))")
                Text("\(moneyStore.money)")
                Spacer()
            }
            .padding()
        }
        .onAppear {
            print("온어피;어")
        }
    }
}

struct DaySpentView_Previews: PreviewProvider {
    static var previews: some View {
        DaySpentView()
    }
}
