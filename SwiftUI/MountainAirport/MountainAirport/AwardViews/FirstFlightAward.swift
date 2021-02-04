
import SwiftUI

struct FirstFlightAward: View {
  var body: some View {
    GeometryReader { geometry in
      Path { path in
        let R = 5.0
        let r = 3.0
        let p = 1.0
        
        let size = min(geometry.size.width, geometry.size.height)
        let ratio = Double(size) / ((R - r) + r * p) / 2.0
        
        var angle = 0
        let maxT = 2880
        var curveClosed = false
        
        var x0: Double = 0
        var y0: Double = 0
        while(angle < maxT && !curveClosed) {
          let theta = Angle.init(degrees: Double(angle)).radians
          let component = ((R + r) / r) * theta
          let x = (R - r) * cos (theta) + r * p * cos(component)
          let y = (R - r) * sin (theta) - r * p * sin(component)

          let xc = x * ratio
          let yc = y * ratio
          if angle == 0 {
            x0 = xc
            y0 = yc
            path.move(to: .init(x: x0, y: y0))
          } else {
            path.addLine(to: .init(x: xc, y: yc))
            if abs(xc - x0) < 0.25 && abs(yc - y0) < 0.25 {
              curveClosed = true
            }
          }
          angle = angle + 1
        }
      }
      .offset(x: geometry.size.width / 2.0, y: geometry.size.height / 2.0)
        .stroke(Color.red, lineWidth: 1)
    }
  }
}

#if DEBUG
struct FirstFlightAward_Previews: PreviewProvider {
  static var previews: some View {
    FirstFlightAward()
      .frame(width: 380, height: 380)
  }
}
#endif
