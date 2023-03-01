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
    @State var isShowingOnboardingView = UserDefaults.standard.object(forKey: "isShowingOnboardingView") as? Bool ?? true
    @State var 첫번째1일인가 = UserDefaults.standard.object(forKey: "첫번째1일인가") as? Bool ?? false
    
    var body: some View {
        if isShowingOnboardingView {
            MoneySettingView(isShowingOnboardingView: $isShowingOnboardingView)
                .onAppear {
                    print("처음 사용자입니다. 돈을 세팅해주세요.")
                }
        } else if 첫번째1일인가 {
            MoneySettingView(isShowingOnboardingView: $첫번째1일인가)
                .onAppear {
                    print("1일입니다. 돈을 다시 세팅해주세요.")
                }
        } else {
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
                            HistoryView()
                        } label: {
                            Image(systemName: "list.bullet.clipboard")
                        }
                        
                        NavigationLink {
                            SettingView()
                        } label: {
                            Image(systemName: "gearshape.fill")
                        }
                    }
                    
                    Text(currentTitleDisplay ? "\(Date(), style: .date)" : "오늘은 \(moneyStore.todayMoney) ₩ 사용가능합니다")
                        .font(.headline)
                        .monospaced()
                        .onTapGesture {
                            currentTitleDisplay.toggle()
                        }
                    Spacer()
                    
                    List {
                        ForEach(Array(zip(moneyStore.spendMoneyHistory, moneyStore.spendContentsHistory).enumerated()).reversed(), id: \.offset) { (_, element) in
                            HStack {
                                Text("-\(element.0) ₩ ")
                                Spacer()
                                Text("\(element.1)")
                            }
                        }
                        .onDelete { IndexSet in
                            print("삭제")
                            let i: Int = IndexSet.first!
                            UserDefaults.standard.set(moneyStore.money + (Int(moneyStore.spendMoneyHistory[i]) ?? 0), forKey: "총금액")
                            moneyStore.money = UserDefaults.standard.integer(forKey: "총금액")

                            UserDefaults.standard.set(moneyStore.todayMoney + (Int(moneyStore.spendMoneyHistory[i]) ?? 0), forKey: "오늘사용가능한돈")
                            moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
                            
                            var tempMoneyArr: [String] = moneyStore.spendMoneyHistory
                            tempMoneyArr.remove(at: i)
                            UserDefaults.standard.set(tempMoneyArr, forKey: "사용한돈")
                            moneyStore.spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []

                            var tempContentArr: [String] = moneyStore.spendContentsHistory
                            tempContentArr.remove(at: i)
                            UserDefaults.standard.set(tempContentArr, forKey: "사용내역")
                            moneyStore.spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []

                            var tempMoneyHistory = moneyStore.moneyHistory
                            tempMoneyHistory.remove(at: i)
                            UserDefaults.standard.set(tempMoneyHistory, forKey: "돈히스토리")
                            moneyStore.moneyHistory = UserDefaults.standard.array(forKey: "돈히스토리") as? [String] ?? []

                            var tempContentHistory = moneyStore.contentHistory
                            tempContentHistory.remove(at: i)
                            UserDefaults.standard.set(tempContentHistory, forKey: "내역히스토리")
                            moneyStore.contentHistory = UserDefaults.standard.array(forKey: "내역히스토리") as? [String] ?? []
                        }
                    }
                    .listStyle(.inset)
                }
                .padding()
            }
            .onAppear {
//                print(moneyStore.spendMoneyHistory)
//                print(moneyStore.spendContentsHistory)
//                print(moneyStore.moneyHistory)
//                print(moneyStore.contentHistory)
                print("전체돈 : \(UserDefaults.standard.integer(forKey: "총금액"))")
                // 초기 day 저장, 날이 변했을때 오늘 사용가능한 돈 업데이트 로직
                if moneyStore.앱을켰을때day == "저장안됨" {
                    UserDefaults.standard.set(moneyStore.오늘날, forKey: "앱을켰을때day")
                    UserDefaults.standard.set(moneyStore.money / (Int(moneyStore.이달의마지막일)! - Int(moneyStore.오늘날)! + 1), forKey: "오늘사용가능한돈")
                    moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
                    print("저장완료")
                } else if moneyStore.앱을켰을때day != moneyStore.오늘날 { // 다음날로 넘어갔을때 로직
                    print("날이바뀜 온어피어")
//                    UserDefaults.standard.set(moneyStore.오늘날, forKey: "앱을켰을때day")
//                    UserDefaults.standard.set(moneyStore.money / (Int(moneyStore.이달의마지막일)! - Int(moneyStore.오늘날)! + 1), forKey: "오늘사용가능한돈")
//                    moneyStore.todayMoney = UserDefaults.standard.integer(forKey: "오늘사용가능한돈")
                    
                    // TODO: 사용한 돈, 사용 내역 초기화 해주기!
                    // 이렇게 해도 안바뀌네??
                    // 온보딩뷰에 온어피어를 걸어서 한번 필터링 된 뷰로 넘어가게 만들어보기!
//                    UserDefaults.standard.set(nil, forKey: "사용한돈")
//                    UserDefaults.standard.set(nil, forKey: "사용내역")
//                    moneyStore.spendMoneyHistory = UserDefaults.standard.array(forKey: "사용한돈") as? [String] ?? []
//                    moneyStore.spendContentsHistory = UserDefaults.standard.array(forKey: "사용내역") as? [String] ?? []
//                    print("update 완료")
                }
            }
        }
    }
}

struct DaySpentView_Previews: PreviewProvider {
    static var previews: some View {
        DaySpentView()
            .environmentObject(MoneyStore())
    }
}
