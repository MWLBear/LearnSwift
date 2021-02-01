
import SwiftUI

struct AirportMealAward: View {
    var body: some View {
        
        GeometryReader(content: { geometry in
            VStack {
                
                Path{ path in
                    let size = min(geometry.size.width, geometry.size.height)
                    let nearLine = size * 0.1
                    let farLine = size * 0.9
                    let mid = size / 2
                    
                    path.move(to: .init(x: mid, y: nearLine))
                    path.addQuadCurve(to: .init(x: farLine, y: mid), control: .init(x: size, y: 0))
                    path.addQuadCurve(to: .init(x: mid, y: farLine), control: .init(x: size, y: size))
                    path.addQuadCurve(to: .init(x: nearLine, y: mid), control: .init(x: 0, y: size))
                    path.addQuadCurve(to: .init(x: mid, y: nearLine), control: .init(x: 0, y: 0))
                }.fill(
                    RadialGradient(gradient: .init(colors: [Color.white, Color.yellow]), center: .init(x: 0.5, y: 0.5), startRadius:  geometry.size.width * 0.05, endRadius: geometry.size.width * 0.6)
                )
            }
            Path { path in
                let size = min(geometry.size.width, geometry.size.height)
                let nearLine = size * 0.1
                let farLine = size * 0.9
                path.addArc(center: .init(x: nearLine, y: nearLine), radius: size / 2,
                            startAngle: .degrees(90), endAngle: .degrees(0), clockwise: true)
                path.addArc(center: .init(x: farLine, y: nearLine), radius: size / 2,
                            startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                path.addArc(center: .init(x: farLine, y: farLine), radius: size / 2,
                            startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
                path.addArc(center: .init(x: nearLine, y: farLine), radius: size / 2,
                            startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
                path.closeSubpath()
            }.stroke(Color.orange, lineWidth: 2)
            
        })
    }
}

struct AirportMealAward_Previews: PreviewProvider {
    static var previews: some View {
        AirportMealAward().frame(width: 200, height: 200)
    }
}
