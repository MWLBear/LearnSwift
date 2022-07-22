//
//  Shapes.swift
//  Cards
//
//  Created by admin on 2022/7/19.
//

import SwiftUI

struct Shapes: View {
  let currentShape = Lens()
    var body: some View {
      currentShape
        .stroke(
          Color.primary,
          style: StrokeStyle(lineWidth:10, lineJoin: .round))
        .padding()
        .aspectRatio(1.0, contentMode: .fit)
        .background(Color.yellow)
    }
}

struct Shapes_Previews: PreviewProvider {
    static var previews: some View {
        Shapes()
        .previewLayout(.sizeThatFits)
    }
}

struct Triangle: Shape {
  func path(in rect: CGRect) -> Path {
    let width = rect.width
    let height = rect.height
    print("1",width,height)
    var path = Path()
    path.addLines([
       CGPoint(x: width * 0.13, y: height * 0.2),
       CGPoint(x: width * 0.87, y: height * 0.47),
       CGPoint(x: width * 0.4, y: height * 0.93)
     ])
    path.closeSubpath()
    return path
  }
}

struct Cone: Shape {
  func path(in rect: CGRect) -> Path {
    let radius = min(rect.midX, rect.midY)
    var path = Path()
    path.addArc(
      center: CGPoint(x: rect.midX, y: rect.midY),
      radius: radius,
      startAngle: Angle(degrees: 0),
      endAngle: Angle(degrees: 180),
      clockwise: true)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.height))
    path.addLine(to: CGPoint(x: rect.midX + radius, y: rect.midY))
    path.closeSubpath()
    return path
  }
}

struct Lens: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    path.move(to: CGPoint(x: 0, y: rect.midY))
    path.addQuadCurve(
      to: CGPoint(x: rect.width, y: rect.midY),
      control: CGPoint(x: rect.midX, y: 0))
   path.addQuadCurve(
      to: CGPoint(x: 0, y: rect.midY),
      control: CGPoint(x: rect.midX, y: rect.height))
    path.closeSubpath()
    return path
  }
}


extension Shapes {
  static let shapes: [AnyShape] = [
    AnyShape(Circle()), AnyShape(Rectangle()),
    AnyShape(Cone()), AnyShape(Lens())
  ]
}
