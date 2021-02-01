
import SwiftUI

struct OverNightParkAward: View {
    var body: some View {
        
        GeometryReader { geometry in
            Path { path in
                let size = min(geometry.size.width, geometry.size.height)
                let nearLine = size * 0.1
                let farLine = size * 0.9
                
                path.move(to: CGPoint(x: size/2 + nearLine, y: nearLine))
                path.addLine(to: .init(x: farLine, y: farLine))
                path.addLine(to: .init(x: nearLine, y: farLine))
                path.addLine(to: .init(x: size/2 - nearLine, y: nearLine))
            }.fill(Color.init(red: 0.4, green: 0.4, blue: 0.4))
            
            Path{ path in
                let size = min(geometry.size.width, geometry.size.height)
                let nearLine = size * 0.1
                let farLine = size * 0.9
                let middle = size / 2
                
                path.move(to: .init(x: middle, y: farLine))
                path.addLine(to: .init(x: middle, y: nearLine))
                
            }.stroke(Color.white,style: .init(lineWidth:3.0,
                                              dash: [geometry.size.height / 20,
                                                     geometry.size.height/30],
                                              dashPhase: 0))
            Image(systemName: "car.fill")
                .resizable()
                .foregroundColor(Color.blue)
                .scaleEffect(0.20)
                .offset(x: -geometry.size.width/7.25)
        }
    }
}

struct OverNightParkAward_Previews: PreviewProvider {
    static var previews: some View {
        OverNightParkAward().frame(width: 200, height: 200)
    }
}
