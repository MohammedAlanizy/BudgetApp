//
//  CustomButton.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

import SwiftUI

struct CustomButton: View {
    @State var title: String = "Title"
    var screenWidth: CGFloat = UIScreen.main.bounds.size.width // by default (the width of the screen) can be modifed when created !
    var click_event: (()->())?
    var body: some View {
        Button {
            click_event?()
        } label: {
            ZStack{
                Image("button_background")
                    .resizable()
                    .scaledToFill()
                    .padding(.horizontal, 20)
                    .frame(width: screenWidth, height: 48)
                
                Text(title)
                    .font(.custom("Inter-SemiBold", size: 12))
                    .padding(.horizontal, 20)
            }
        }
        .foregroundColor(.white)
        .shadow(color: .secondary.opacity(0.3), radius: 5, y: 3)
    }
}


#Preview {
    CustomButton()
}
