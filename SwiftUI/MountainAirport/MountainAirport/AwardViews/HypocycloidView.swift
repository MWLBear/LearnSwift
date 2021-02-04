

import SwiftUI

struct HypocycloidView: View {
  var R: Double
  var r: Double
  var p = 1.0
  var color = Color.red
  
  var awardTitle: String {
    get {
      return "\(self.R):\(self.r):\(self.p)"
    }
  }
  
  var body: some View {
    GeometryReader { geometry in
      Path { path in
        
        let size = min(geometry.size.width, geometry.size.height)
        let ratio = Double(size) / ((self.R - self.r) + self.r * self.p) / 2.0
        
        var angle = 0
        let maxT = 2880
        var curveClosed = false
        
        var x0: Double = 0
        var y0: Double = 0
        while(angle < maxT && !curveClosed) {
          let theta = Angle.init(degrees: Double(angle)).radians
          let component = ((self.R + self.r) / self.r) * theta
          let x = (self.R - self.r) * cos (theta) + self.r * self.p * cos(component)
          let y = (self.R - self.r) * sin (theta) - self.r * self.p * sin(component)
          
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
        .stroke(self.color, lineWidth: 1)
    }
  }
}

#if DEBUG
struct HypocycloidView_Previews: PreviewProvider {
  static var previews: some View {
    HypocycloidView(R: 5, r: 3)
      .frame(width: 250, height: 250)
  }
}
#endif
