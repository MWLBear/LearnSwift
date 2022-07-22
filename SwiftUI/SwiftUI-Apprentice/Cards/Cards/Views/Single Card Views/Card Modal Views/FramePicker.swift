//
//  FramePicker.swift
//  Cards
//
//  Created by admin on 2022/7/19.
//

import SwiftUI
import simd

struct FramePicker: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var frame: AnyShape?
  let columns = [
    GridItem(.adaptive(minimum: 120), spacing: 0)
  ]
  private let style = StrokeStyle(
    lineWidth: 5,
    lineJoin: .round
  )
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(0..<Shapes.shapes.count,id:\.self) {index in

          Shapes.shapes[index]
            .stroke(Color.primary, style:style)
            .background(
              Shapes.shapes[index].fill(Color.secondary)
            )
            .frame(width: 100, height: 120)
            .padding()
            .onTapGesture {
              frame = Shapes.shapes[index]
              presentationMode.wrappedValue.dismiss()
            }
        }
      }
    }
    .padding()
  }
}

struct FramePicker_Previews: PreviewProvider {
  static var previews: some View {
    FramePicker(frame: .constant(nil))
  }
}
