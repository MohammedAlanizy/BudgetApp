//
//  HomePage.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subArr: FetchedResults<Transactions>
    @State var selectedTab: Int = 0
    @State private var isShowingAddTranscation = false
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
            ZStack{
                
                switch selectedTab {
                    
                case 0:
                    FirstPage()
                        .frame(width: screenWidth, height: screenHeight)
                case 1:
                    AddSNW()
                        .frame(width: screenWidth, height: screenHeight)
                case 2:
                    AnotherChar()
                        .frame(width: screenWidth, height: screenHeight)
                case 3:
                    Text("Nothing yet!")
                        .frame(width: screenWidth, height: screenHeight)
                default:
                    FirstPage()
                        .frame(width: screenWidth, height: screenHeight)
                }
                VStack{
                    Spacer()
                    
                    ZStack(alignment: .bottom){
                        Spacer()
                        
                        
                        ZStack(alignment: .bottom) {
                            Image("bacground_bottom")
                                .resizable()
                                .scaledToFit()

                            
                            HStack(alignment: .center, spacing: 0){
                                
                                Spacer()
                                Button {
                                    selectedTab = 0
                                } label: {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                }
                                .foregroundColor( selectedTab == 0 ? .white : .gray )
                                
                                Spacer()
                                Button {
                                    selectedTab = 1
                                } label: {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                }
                                .foregroundColor( selectedTab == 1 ? .white : .gray )
                                
                                
                                Rectangle()
                                    .fill(.clear)
                                    .frame(width: 80, height: 0)
                                
                                Button {
                                    selectedTab = 2
                                } label: {
                                    Image(systemName: "chart.pie.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                }
                                .foregroundColor( selectedTab == 2 ? .white : .gray )
                                
                                Spacer()
                                Button {
                                    selectedTab = 3
                                } label: {
                                    Image(systemName: "gear")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding()
                                }
                                .foregroundColor( selectedTab == 3 ? .white : .gray )
                                Spacer()
                            }.frame(width: screenWidth)
                            Spacer()
                        }
                        
                        Button {
                            isShowingAddTranscation = true
                        } label: {
                            Image("add_button")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding()
                        }
                    
                        .padding(.bottom, 6)
                        .shadow(color: .secondary.opacity(0.5), radius: 6,y: 4)
                    }
                
                }
            
                .padding(.horizontal, 20)
            }
            .background(Color.gray)
            .ignoresSafeArea()
            .sheet(isPresented: $isShowingAddTranscation, content: {
                AddSubscruiptionView(UIState:UIStateModel())
            })
        
    }
}

#Preview {
    HomePage()
}
