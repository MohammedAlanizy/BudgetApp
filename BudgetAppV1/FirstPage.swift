//
//  FirstPage.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI
import CoreData

struct FirstPage: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subArr: FetchedResults<Transactions>
    @FetchRequest(sortDescriptors: []) private var threeDataIte: FetchedResults<ThreeData>
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
                    ArcShape(start: 0, end: 0)
                        .modifier(ArcShapeModifier(start:0,end:savingsTotalAn, color: .red))
                        .foregroundColor(.red)
                        .shadow( color: .red.opacity(0.5) , radius: 7)
                    ArcShape(start: 0, end: 0)
                        .modifier(ArcShapeModifier(start:savingsTotalAn,end: wantsTotalAn,color:.blue))
                        .foregroundColor(.blue)
                        .shadow( color: .blue.opacity(0.5) , radius: 7)
                    ArcShape(start:0, end: 0)
                        .modifier(ArcShapeModifier(start:wantsTotalAn2,end: needsTotalAn ,color:.purple))
                        .foregroundColor(.purple)
                        .shadow( color: .purple.opacity(0.5) , radius: 7)
                }
                .frame(width: (screenWidth * 0.72), height: (screenWidth * 0.72) )
                .padding(.bottom, 18)
                
                VStack(spacing: (screenWidth * 0.07)){
                    HStack{
                        Image(systemName: "calendar.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth * 0.1 )
                        Text("Centsible")
                    }.foregroundColor(.white)
                    
                    Text("$\(savingsTotal+needsTotal+wantsTotal, specifier: "%.2f")")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("Total of this month")
                        .font(.caption)
                        .foregroundColor(.gray)
                    

                }
                
                VStack{
                    Spacer()
                    HStack{
                        TransactionView(title: "Savings", value: $savingsTotalS,color: .red) {
                            
                        }
                        
                        TransactionView(title: "Wants", value: $wantsTotalS,color: .blue) {
                            
                        }
                        
                        TransactionView(title: "Needs", value: $needsTotalS,color: .purple) {
                            
                        }
                        
                        
                    }
                }
                .padding()
                
            }
            .frame(width: screenWidth, height: screenWidth * 1.1 )
            
            HStack{
                
                Button {
                } label: {
                    Text("Transcations :")
                        .font(Font.custom("Inter-SemiBold", size: 12))
                        .foregroundColor(.white)
                }
                .foregroundColor( .white )
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 42, maxHeight: 42)
                
                .background(Color.gray.opacity( 0.1  ))
                .cornerRadius(12)
                
            }
            .padding(8)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(Color.black)
            .cornerRadius(15)
            .padding()
            
                LazyVStack(spacing: 15) {
                    ForEach( subArr) { sObj in
                        withAnimation{
                            TransactiionRow(item: TransactionModel(dict: ["id": sObj.id ?? "0","name":sObj.name ?? "name", "icon":sObj.icon ?? "icon", "price": sObj.price ?? "0.00"] )).id(sObj.id)
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
            
        }
        .onAppear{
            threeDataIte.forEach{ sObj in
                if (sObj.type == "needs"){
                    needsTotal +=  sObj.value
                }else if (sObj.type == "wants"){
                    wantsTotal += sObj.value
                }else{
                    savingsTotal += sObj.value
                }
            }
            withAnimation(Animation.spring(duration: 1)) {
                needsTotalS = String(needsTotal)
                wantsTotalS = String(wantsTotal)
                savingsTotalS = String(savingsTotal)
                savingsTotalAn =  (savingsTotal)/(savingsTotal+needsTotal+wantsTotal)*(screenWidth * 0.72)
                wantsTotalAn = (wantsTotal)/(savingsTotal+needsTotal+wantsTotal)*(screenWidth * 0.72)
                wantsTotalAn2 = (wantsTotal)/(savingsTotal+needsTotal+wantsTotal)*(screenWidth * 0.72)+(((wantsTotal)/(savingsTotal+needsTotal+wantsTotal)*(screenWidth * 0.72)) - 25)
                needsTotalAn = (needsTotal)/(savingsTotal+needsTotal+wantsTotal)*(screenWidth * 0.72)
            }
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstPage()
    }
}

