//
//  SunWaveView.swift
//  CloneWheather
//
//  Created by Andrei Olaru on 24.11.2024.
//

import SwiftUI

struct SunWaveView: View {
    let dayColor: Color
    let nightColor: Color
    let sunColor: Color
    let horizonColor: Color
    let waveStrokeWidth: CGFloat = 4.0
    let horizonStrokeWidth: CGFloat = 1.0
    let sunPosition: CGFloat
    
    var body: some View {
        ZStack {
            GeometryReader { proxy in
                Wave()
                    .stroke(nightColor, lineWidth: waveStrokeWidth)
                Wave()
                    .stroke(dayColor, lineWidth: waveStrokeWidth)
                    .mask {
                        GeometryReader { innerProxy in
                            Rectangle()
                                .foregroundStyle(.red)
                                .frame(
                                    width:  innerProxy.size.width,
                                    height: innerProxy.size.height / 2.0)
                        }
                    }
                Rectangle()
                    .foregroundStyle(horizonColor)
                    .frame(height: horizonStrokeWidth)
                    .position(CGPoint(x: proxy.size.width / 2.0, y: proxy.size.height / 2.0))
                    .shadow(color: .gray.opacity(0.3), radius: 1.0)
                Circle()
                    .frame(width: 15)
                    .foregroundStyle(sunColor)
                    .shadow(color: sunColor, radius: 4)
                    .position(Wave.point(for: proxy.size.width * sunPosition,
                                         in: CGRect(origin: CGPoint.zero, size: proxy.size)))
            }
        }
        .padding()
    }
}

struct Wave: Shape {
    let resolution: Int = 10
    let amplitude: Int = 1
    
    static func point(for x: CGFloat, in rect: CGRect) -> CGPoint {
        let freq = 1 * (2 * 3.1415)
        let waveLength = rect.width / CGFloat(freq)
        let relativeX = x / waveLength
        let y = (cos(relativeX) * rect.height / 2) + rect.midY
        
        return CGPoint(x: x, y: y)
    }
    
    func path(in rect: CGRect) -> Path {
        let freq = 1 * (2 * 3.1415)
        let width = rect.width
        let wavelength = rect.width / CGFloat(freq)
        
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        
        let path = UIBezierPath()
        
        path.move(to: startPoint)
        
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / wavelength
            let y = (cos(relativeX) * rect.height / 2) + startPoint.y
            let point = CGPoint(x: x, y: y)
            
            if x == 0 {
                path.move(to: point)
                continue
            }
            
            path.addLine(to: point)
        }
        
        return Path(path.cgPath)
    }
}

#Preview {
    SunWaveView(dayColor: .green, nightColor: .blue, sunColor: .white, horizonColor: .gray, sunPosition: 1.0)
}
