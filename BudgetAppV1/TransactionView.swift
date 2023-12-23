//
//  TransactionView.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//
import SwiftUI

struct TransactionView: View {
    @State var title: String = "Title"
    @Binding var value: String
    @State var color: Color = .secondary
    var multiply_by:Double = 1.0
    var click_events: (()->())?
    var body: some View {
        
        Button {
            click_events?()
        } label: {
            ZStack(alignment: .top){
                VStack{
                    VStack{
                        Text(title)
                            .font(.custom("Inter-SemiBold", size: 12))
                            .foregroundColor(.gray)
                        
                        Text("$\((Double(value) ?? 0.0) * (multiply_by) , specifier: "%.2f")")
                            .font(.custom("Inter-SemiBold", size: 14))
                            .foregroundColor(.white)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 68, maxHeight: 68)
                
                .background(Color.gray.opacity(  0.2 ))
                .overlay {
                    RoundedRectangle(cornerRadius:  16)
                        .stroke( Color.gray.opacity(0.5), lineWidth: 1)
                }
                .cornerRadius(16)
                
                Rectangle()
                    .fill(color)
                    .frame(width: 60, height: 1, alignment: .center)
            }
        }

        
    }
}
#Preview {
    TransactionView(value: .constant("$0.00"))
}
