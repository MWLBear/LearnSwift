//
//  GradientBackground.swift
//  HIITFit
//
//  Created by admin on 2022/6/21.
//

import SwiftUI

struct GradientBackground: View {
  var gradient: Gradient {
    let color1 = Color("gradient-top")
    let color2 = Color("gradient-bottom")
    let background = Color("background")
    return Gradient(
      stops: [
        Gradient.Stop(color: color1, location: 0),
        Gradient.Stop(color: color2, location: 0.9),
        Gradient.Stop(color: background, location: 0.9),
        Gradient.Stop(color: background, location: 1)
      ])
  }
  var body: some View {
    LinearGradient(
      gradient: gradient,
      startPoint: .top,
      endPoint: .bottom)
      .edgesIgnoringSafeArea(.all)
  }
}

struct GradientBackground_Previews: PreviewProvider {
  static var previews: some View {
    GradientBackground()
      .frame(width: 300, height: 300)
      .previewLayout(.sizeThatFits)
  }
}
