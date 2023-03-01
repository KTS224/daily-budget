//
//  SettingView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct SettingView: View {
    @State private var isDarkMode = false
    
    var body: some View {
        List {
            NavigationLink {
                MoneySettingView(isShowingOnboardingView: .constant(false))
            } label: {
                Text("금액변경")
            }

//            Text("테마변경")
//            Text("언어변경")
//            Text("라이선스")
//            Toggle("다크모드", isOn: $isDarkMode)
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
