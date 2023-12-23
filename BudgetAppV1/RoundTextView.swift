//
//  RoundTextView.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

struct RoundTextField: View {
    
    @State var TitleOfTextBox: String = "Title"
    @Binding var textBinding: String
    var textAlign:Alignment  = .leading
    
    var body: some View {
        VStack{
            Text(TitleOfTextBox)
                .multilineTextAlignment(.leading)
                .font(Font.custom("Inter-Regular", size: 14))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: textAlign)
                
                .foregroundColor(.gray)
                .padding(.bottom, 4)
            
                TextField("", text: $textBinding)
                    .padding(15)
                    .keyboardType(.default)
                    .frame(height: 48)
                    .overlay {
                        RoundedRectangle(cornerRadius:  15)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .foregroundColor(.white)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(15)
            
            
            
        }
    }
}

struct RoundTextField_Previews: PreviewProvider {
    @State static var txt: String = ""
    static var previews: some View {
        RoundTextField(textBinding: $txt)
    }
}
