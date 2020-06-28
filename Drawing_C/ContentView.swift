//
//  ContentView.swift
//  Drawing_C
//
//  Created by Subhrajyoti Chakraborty on 28/06/20.
//  Copyright © 2020 Subhrajyoti Chakraborty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 100.0
    @State private var thickness = 10.0
    @State private var hue = 0.6
    
    var body: some View {
        VStack {
            Arrow(thickness: CGFloat(amount))
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), style: StrokeStyle(lineWidth: CGFloat(thickness), lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation{
                        self.amount = Double.random(in: 0.0...150.0)
                    }
                }
            .frame(width: 300, height: 400)
            .padding([.bottom])
            
            
            Group {
                Text("Thickness: \(thickness, specifier: "%.2f")")
                Slider(value: $thickness, in: 5...60, step: 1)
                
                Text("Colour")
                Slider(value: $hue)
            }
            .padding([.top, .horizontal])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Arrow: Shape {
    
    var thickness: CGFloat
    
    var animatableData: CGFloat {
        get {thickness}
        set {self.thickness = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - thickness, y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.maxX - thickness, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - (thickness / 2), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - (thickness / 2), y: rect.midY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        
        
        return path
    }
}
