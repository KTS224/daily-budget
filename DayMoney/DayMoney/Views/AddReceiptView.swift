//
//  AddReceiptView.swift
//  DayMoney
//
//  Created by 김태성 on 2023/02/25.
//

import SwiftUI

struct AddReceiptView: View {
    var body: some View {
        VStack {
            
            
            Button {
                print("추가")
            } label: {
                Text("추가하기")
            }

        }
    }
}

struct AddReceiptView_Previews: PreviewProvider {
    static var previews: some View {
        AddReceiptView()
    }
}
