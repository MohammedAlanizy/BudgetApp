//
//  FirstPage.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI
import CoreData
import SunburstDiagram

struct AnotherChar: View {
    
    @State var isSubscription: Bool = true

    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subArr: FetchedResults<Transactions>
    @State var needsList: [Node] = []
    @State var wantsList: [Node] = []
    @State var savingsList: [Node] = []
    @State var configuration = SunburstConfiguration(nodes: [])
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    @State var savingsTotal:Double = 0.0
    @State var needsTotal:Double = 0.0
    @State var wantsTotal:Double = 0.0
    @State var savingsTotalAn:Double = 0.0
    @State var needsTotalAn:Double = 0.0
    @State var wantsTotalAn:Double = 0.0
    @State var wantsTotalAn2:Double = 0.0
    @State var savingsTotalS:String = ""
    @State var needsTotalS:String = ""
    @State var wantsTotalS:String = ""
    var body: some View {
        ScrollView {
            
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundColor(.gray.opacity(0.5))
                    .frame(width: screenWidth, height: (screenWidth * 1.1) )
                    .cornerRadius(25)
                
                
                Image("home_background")
                    .resizable()
                    .scaledToFit()
                
                ZStack{
                    var configuration = SunburstConfiguration(nodes: [
                        Node(name: "Wants", value: 20.0, backgroundColor: .systemBlue, children: wantsList),
                        Node(name: "Needs", value: 30.0, backgroundColor: .systemRed, children: needsList),
                        Node(name: "Savings", value: 10.0, backgroundColor: .systemPurple,children: savingsList),
                    ])
                    SunburstView(configuration: configuration)
                }
                .padding(.top, 35)
                

                

                
            }
            .frame(width: screenWidth, height: screenWidth * 1.1 )
            
        }
        .onAppear{
            subArr.forEach{ sObj in
                if (sObj.type == "needs"){
                    needsList.append(Node(name: sObj.name ?? "!", value: Double(sObj.price ?? "0.00") ?? 0.00, backgroundColor: .cyan))
                }else if (sObj.type == "wants"){
                    wantsList.append(Node(name: sObj.name ?? "!", value: Double(sObj.price ?? "0.00") ?? 0.00, backgroundColor: .yellow))
                }else{
                    savingsList.append(Node(name: sObj.name ?? "!", value: Double(sObj.price ?? "0.00") ?? 0.00, backgroundColor: .magenta))
                }
            }
            withAnimation(Animation.spring(duration: 1)) {
                self.configuration = SunburstConfiguration(nodes: [
                    Node(name: "Wants", value: 20.0, backgroundColor: .systemBlue, children: wantsList),
                    Node(name: "Needs", value: 30.0, backgroundColor: .systemRed, children: needsList),
                    Node(name: "Savings", value: 10.0, backgroundColor: .systemPurple,children: savingsList),
                ])
                
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct AnotherChar_Previews: PreviewProvider {
    static var previews: some View {
        AnotherChar(needsList: [Node(name: "Savings", value: 10.0, backgroundColor: .systemPurple)], wantsList: [Node(name: "Savings", value: 10.0, backgroundColor: .systemPurple)], savingsList: [Node(name: "Savings", value: 10.0, backgroundColor: .systemPurple)])
    }
}

