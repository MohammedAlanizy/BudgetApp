//
//  ArcShape.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

struct ArcShapeModifier: AnimatableModifier { // to make animation for the arc
    var start: Double
    var end: Double
    var color: Color
    var animatableData: Double {
        get { end }
        set { end = newValue }

    }
    var animatableData2: Double {
        get { start }
        set { start = newValue }
    }

    func body(content: Content) -> some View {
        content
            .overlay(
                ArcShape(start: start,end: end)
                    .stroke(color, lineWidth: 13)
            )
    }
}


struct ArcShape: Shape {
    var start: Double = 0
    var end: Double
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let startVal = (start + 135)
        
        p.addArc(
            center: CGPoint(x: rect.width / 2, y: rect.height / 2),
            radius: rect.width / 2,
            startAngle: .degrees(startVal.truncatingRemainder(dividingBy: 360)),
            endAngle: .degrees((startVal + end).truncatingRemainder(dividingBy: 360)),
            clockwise: false
        )
        
        return p.strokedPath(.init(lineWidth: 15, lineCap: .round))
    }
}
