//
//  PencilView.swift
//  Cards
//
//  Created by admin on 2022/7/18.
//

import SwiftUI
import PencilKit


struct PencilView: View {
  @Environment(\.undoManager) private var undoManager
  @State private var canvasView = PKCanvasView()

  var body: some View {
    VStack(spacing: 10) {
      Button("Clear") {
        canvasView.drawing = PKDrawing()
      }
      Button("Undo") {
        undoManager?.undo()
      }
      Button("Redo") {
        undoManager?.redo()
      }
      PencilViewRepresentable(canvas: $canvasView)
    }
  }
}

struct PencilView_Previews: PreviewProvider {
  static var previews: some View {
    PencilView()
  }
}

struct PencilViewRepresentable: UIViewRepresentable {
  @Binding var canvas: PKCanvasView

  func makeUIView(context: Context) -> some UIView {
    canvas.drawingPolicy = .anyInput
    canvas.tool = PKInkingTool(.pen, color: .black, width: 15)
    return canvas
  }

  func updateUIView(_ uiView: UIViewType, context: Context) {

  }

}
