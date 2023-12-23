//
//  AddTransaction.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI
import SymbolPicker
import EmojiPicker

struct AddSNW: View {
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subArrLast: FetchedResults<ThreeData>
    @State var displayEmojiPicker: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State var txtPrice: String = ""
    @State var txtDescription: String = ""
    @State var pathProgressSaving: Double = 0.0
    @State var pathProgressNeeds: Double = 0.0
    @State var pathProgressWants: Double = 0.0
    @State var showingAlert: Bool = false
    let saving_by: Double = 0.2
    let wants_by: Double = 0.3
    let needs_by: Double = 0.5
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
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
                        .modifier(ArcShapeModifier(start:0,end: pathProgressSaving, color: .red))
                        .foregroundColor(.red)
                        .shadow( color: .red.opacity(0.5) , radius: 7)
                    ArcShape(start: 0, end: 0)
                        .modifier(ArcShapeModifier(start:pathProgressSaving,end: pathProgressWants,color:.blue))
                        .foregroundColor(.blue)
                        .shadow( color: .blue.opacity(0.5) , radius: 7)
                    ArcShape(start:0, end: 0)
                        .modifier(ArcShapeModifier(start:pathProgressWants+50,end: pathProgressNeeds,color:.purple))
                        .foregroundColor(.purple)
                        .shadow( color: .purple.opacity(0.5) , radius: 7)
                }
                .frame(width: (screenWidth * 0.72), height: (screenWidth * 0.72) )
                .padding(.bottom, 18)
                VStack(spacing: (screenWidth * 0.07)){
                    HStack{
                        Text("💸 Payday ! ")
                    }.foregroundColor(.white)
                    
                    Text("$\(Double(txtDescription) ?? 0.0, specifier: "%.2f")")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("This month")
                        .font(.caption)
                        .foregroundColor(.gray)
                    

                }
                
                VStack{
                    Spacer()
                    HStack{
                        TransactionView(title: "Savings\n(%\(saving_by*100))", value:$txtDescription,color: .red, multiply_by: saving_by) {
                            
                        }
                        
                        TransactionView(title: "Wants\n(%\(wants_by*100))", value: $txtDescription,color: .blue, multiply_by: wants_by) {
                            
                        }
                        
                        TransactionView(title: "Needs\n(%\(needs_by*100))", value: $txtDescription,color: .purple, multiply_by: needs_by) {
                            
                        }
                        
                        
                    }
                }
                .padding()
                
            }
            .frame(width: screenWidth, height: screenWidth * 1.1 )
            .frame(width: screenWidth )
                HStack{
                    Spacer()
                    RoundTextField(TitleOfTextBox: "💰 :", textBinding: $txtDescription, textAlign: .center)
                        .frame(width: screenWidth - 190 )
                        .onChange(of: txtDescription) { oldValue, newValue in
                            withAnimation(Animation.easeInOut(duration: 0.4)) {
                                if ((Double(newValue) ?? 0.0) > 0){
                                    pathProgressSaving = saving_by*screenWidth*0.72
                                    pathProgressWants = wants_by*screenWidth*0.72
                                    pathProgressNeeds = needs_by*screenWidth*0.72
                                }else{
                                    pathProgressSaving = 0
                                    pathProgressWants = 0
                                    pathProgressNeeds = 0
                                }
                            }
                        }
                    Spacer()
                    
                }
                .padding()
                

            
            CustomButton(title: "Create",screenWidth: screenWidth - 300) {
                let newTask = ThreeData(context: viewContext)
                newTask.id = UUID()
                newTask.value = (Double(txtDescription) ?? 0.0) * saving_by
                newTask.type = "savings"
                try? viewContext.save()
                let newTask2 = ThreeData(context: viewContext)
                newTask2.id = UUID()
                newTask2.value = (Double(txtDescription) ?? 0.0) * wants_by
                newTask2.type = "wants"
                try? viewContext.save()
                let newTask3 = ThreeData(context: viewContext)
                newTask3.id = UUID()
                newTask3.value = (Double(txtDescription) ?? 0.0) * needs_by
                newTask3.type = "needs"
                try? viewContext.save()
                showingAlert = true
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .alert("Added successfully ! ✅", isPresented: $showingAlert) {
                    Button("Great", role: .cancel) {
                        showingAlert = false
                        txtDescription = ""
                        txtPrice  = ""
                    }
                }
        .background(Color.black.opacity(0.9))
        .ignoresSafeArea()
    }
}


#Preview {
    AddSNW()
}

