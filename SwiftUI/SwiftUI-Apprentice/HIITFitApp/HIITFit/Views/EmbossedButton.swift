//
//  EmbossedButton.swift
//  HIITFit
//
//  Created by admin on 2022/6/20.
//

import SwiftUI

enum EmbossedButtonShape {
  case round, capsule
}

struct EmbossedButton: View {
  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

struct EmbossedButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Button(
        action: {},
        label: {
          Text("History")
            .fontWeight(.bold)
        })
        .buttonStyle(EmbossedButtonStyle(buttonShape: .round))
        .padding(40)
      .previewLayout(.sizeThatFits)
      Button(
        action: {},
        label: {
          Text("History")
            .fontWeight(.bold)
        })
        .preferredColorScheme(.dark)
        .buttonStyle(EmbossedButtonStyle())
        .padding(40)
        .previewLayout(.sizeThatFits)
    }
  }
}

struct EmbossedButtonStyle: ButtonStyle {
  var buttonShape = EmbossedButtonShape.capsule
  func makeBody(configuration: Configuration) -> some View {
    let shadow = Color("drop-shadow")
    let highlight = Color("drop-highlight")
    return configuration.label
      .padding(10)
      .background(
        GeometryReader { geometry in
          shape(size: geometry.size)
            .shadow(color: shadow, radius: 1, x: 2, y: 2)
            .shadow(color: highlight, radius: 1, x: -2, y: -2)
            .offset(x: -1, y: -1)
        }
      )
  }
  @ViewBuilder
  func shape(size: CGSize) -> some View {
    switch buttonShape {
    case .round:
      Circle()
        .stroke(Color("background"), lineWidth: 2)
        .frame(
          width: max(size.width, size.height),
          height: max(size.width, size.height))
        .offset(x: -1)
        .offset(y: -max(size.width, size.height) / 2 + min(size.width, size.height) / 2)
    case .capsule:
      Capsule()
        .stroke(Color("background"), lineWidth: 2)
    }
  }
}
