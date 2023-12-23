//
//  AddTransaction.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI
import SymbolPicker
import EmojiPicker
public class UIStateModel: ObservableObject
{
    @Published var activeCard: Int      = 0
    @Published var screenDrag: Float    = 0.0
}
struct AddSubscruiptionView: View {
    var UIState: UIStateModel
    @State var selectedEmoji: Emoji?
    @EnvironmentObject var manager: DataManager
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: []) private var subArrLast: FetchedResults<Transactions>
    @State var displayEmojiPicker: Bool = false
    @Environment(\.dismiss) private var dismiss
    @State var txtDescription: String = ""
    @State var txtPrice: String = ""
    @State var defaultTypesOfTransaction: [TransactionModel] = [
        TransactionModel(dict: ["id":0,"name":"Needs", "icon":"needs", "price": "0.00"] )
        ,
        TransactionModel(dict: ["id":1,"name": "Wants","icon": "wants","price": "0.00"] )
        ,
        TransactionModel(dict: ["id":2,"name":"Savings", "icon":"savings", "price": "0.00"] )
    ]
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    var body: some View {
        ScrollView {
            
            ZStack(alignment: .center) {
                
                Rectangle()
                    .foregroundColor(.gray.opacity(0.2))
                    .frame(width: screenWidth )
                    .cornerRadius(25)
                
                VStack{
                    
                    ZStack{
                        HStack{
                            Button {
                                dismiss()
                            } label: {
                                Text("X")
                                    .frame(width: 50    , height: 50)
                            }
                            
                            Spacer()
                            
                        }
                        

                    }
                    
                    .foregroundColor(.gray)
                    
                    
                    Text("Add a new\ntransaction")
                        .font(.custom("Inter-Bold", size: 40))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.7))
                    
                    Canvas
                    {
                        Carousel( numberOfItems: CGFloat( defaultTypesOfTransaction.count ), spacing: 16, widthOfHiddenCards: 80 )
                        {
                            ForEach( defaultTypesOfTransaction, id: \.self.id ) { item in
                                Item( _id:                  Int(item.itemId),
                                      spacing:              16,
                                      widthOfHiddenCards:   80,
                                      cardHeight:           200 )
                                {
                                    
                                    VStack{
                                        
                                        Image(item.icon)
                                            .resizable()
                                            .scaledToFit()
                                        
                                        Spacer()
                                            .frame(height: 20)
                                        Text("\(item.name)")
                                    }
                                    
                                    
                                }
                                .foregroundColor( .white.opacity(0.8) )
                                .cornerRadius( 8 )
                                .shadow(  radius: 4, x: 0, y: 4 )
                                .transition( AnyTransition.slide )
                                .animation( .smooth() )
                            }
                        }
                        .environmentObject( self.UIState )
                    }
                    .padding(.vertical, 20)
                   
                    
                }
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                
            }
            .frame(width: screenWidth )
            HStack{
                Spacer()
                VStack{
                    Text("Icon")
                        .multilineTextAlignment(.leading)
                        .font(Font.custom("Inter-Regular", size: 14))
                        .foregroundColor(.gray)
                        .padding(.bottom,1)
                    GeometryReader { geometry in
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(Color.gray.opacity(0.1))
                                .onTapGesture {
                                    displayEmojiPicker = true
                                }
                            Text(selectedEmoji?.value ?? "🍔")
                                .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
                                .foregroundColor(.white.opacity(0.8))
                                .padding(10)
                        }
                    }
                    .frame(width: 50, height: 40)
                    Spacer()
                }
                Spacer()
                RoundTextField(TitleOfTextBox: "Price", textBinding: $txtPrice, textAlign: .center)
                    .frame(width: screenWidth - 220 )
                Spacer()
            }
            .padding()
            RoundTextField(TitleOfTextBox: "Description", textBinding: $txtDescription, textAlign: .center)
                .frame(width: screenWidth - 100 )
                .padding(.bottom,20)
            

            
            
            CustomButton(title: "Add a transaction! ") {
                let newTask = Transactions(context: viewContext)
                newTask.itemId = Int64(subArrLast.endIndex+1)
                newTask.name = txtDescription
                if (UIState.activeCard == 0){
                    newTask.type = "needs"
                }else if(UIState.activeCard == 1){
                    newTask.type = "wants"
                }else{
                    newTask.type = "savings"
                }
                newTask.icon = selectedEmoji?.value ?? "🍔"
                newTask.price = txtPrice
                newTask.id = UUID()
                try? viewContext.save()
                dismiss()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            
            
        }
        .background(Color.black.opacity(0.9))
        .sheet(isPresented: $displayEmojiPicker) {
            NavigationView {
                EmojiPickerView(selectedEmoji: $selectedEmoji, selectedColor: .orange)
                    .navigationTitle("Emojis")
                    .navigationBarTitleDisplayMode(.inline)
            }
            }
    }
}


#Preview {
    AddSubscruiptionView(UIState: UIStateModel())
}


