//
//  TransactiionRow.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

struct TransactiionRow: View {
    @State var item: TransactionModel = TransactionModel(dict: ["name":"Spotify", "icon":"📕", "price": "5.99"] )
    var body: some View {
        HStack{

            GeometryReader { geometry in
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .foregroundColor(Color.gray.opacity(0.1))

                    Text(item.icon )
                        .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .frame(width: 50, height: 40)
            Text(item.name)
                .foregroundColor(.white)
            
            Spacer()
            
            Text( "$\(item.price)" )
                .foregroundColor(.white)
                
    
            
        }
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 64, maxHeight: 64)
        
        .background(Color.gray.opacity( 0.2  ))
        .overlay {
            RoundedRectangle(cornerRadius:  12)
                .stroke(  Color.gray, lineWidth: 1)
        }
        .cornerRadius(12)
    }
}

#Preview {
    TransactiionRow()
}
