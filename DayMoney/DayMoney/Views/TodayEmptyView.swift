//
//  TodayEmptyView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/03/01.
//

import SwiftUI

struct TodayEmptyView: View {
    var body: some View {
        VStack {
            Text("오늘의 소비 내역이 없네요!")
                .foregroundColor(.gray)
                .padding(.top, 50)
            Spacer()
        }
    }
}

struct TodayEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        TodayEmptyView()
    }
}
