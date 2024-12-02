//
//  ProgrssViewComponentView.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 17.11.2024.
//

import SwiftUI

struct ProgressViewComponentView: ProgressViewStyle {
    let range: ClosedRange<Double>
    let foregroundColor: AnyShapeStyle
    let backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        
        return GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(backgroundColor)
                Capsule()
                    .fill(foregroundColor)
                    .frame(width: proxy.size.width * fillWidthScale)
                    .offset(x: proxy.size.width * range.lowerBound)
                Circle()
                    .foregroundColor(backgroundColor)
                    .frame(width: proxy.size.height + 4.0, height: proxy.size.height + 4.0)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)
                Circle()
                    .foregroundColor(.white)
                    .position(x: proxy.size.width * (configuration.fractionCompleted ?? 0.0), y: proxy.size.height/2.0)
            }
            .clipped()
        }
    }
    
    var fillWidthScale: CGFloat{
        let normalizedRange = range.upperBound - range.lowerBound
        return Double(normalizedRange)
    }
}

#Preview {
    ScrollView {
        VStack {
            ForEach(0...10, id:\.self) { value in
                let range = 0.0...(Double(value)/10.0)
                let gradient = LinearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing)
                ProgressView(value: 0.5)
                    .frame(height: 10)
                    .progressViewStyle(ProgressViewComponentView(range: range,
                                                                 foregroundColor: AnyShapeStyle(gradient),
                                                                 backgroundColor: .green))
                    .padding()
            }
            ForEach(0...10, id:\.self) { value in
                let range = (Double(value)/10.0)...1.0
                
                ProgressView(value: 0.5)
                    .frame(height: 10)
                    .progressViewStyle(ProgressViewComponentView(range: range,
                                                                 foregroundColor: AnyShapeStyle(.blue),
                                                                 backgroundColor: .green))
                    .padding()
            }
            ProgressView(value: 0.5)
                .frame(height: 10)
                .progressViewStyle(ProgressViewComponentView(range: 0.1...0.9,
                                                             foregroundColor: AnyShapeStyle(.blue),
                                                             backgroundColor: .green))
                .padding()
            ProgressView(value: 0.5)
                .frame(height: 10)
                .progressViewStyle(ProgressViewComponentView(range: 0.3...0.7,
                                                             foregroundColor: AnyShapeStyle(.blue),
                                                             backgroundColor: .green))
                .padding()
            ProgressView(value: 0.5)
                .frame(height: 10)
                .progressViewStyle(ProgressViewComponentView(range: 0.4...0.9,
                                                             foregroundColor: AnyShapeStyle(.blue),
                                                             backgroundColor: .green))
                .padding()
        
        }
    }
}
