//
//  CardBottomToolbar.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct ToolbarButtonView: View {
  private let modalButton:
  [CardModal: (text: String, imageName: String)] = [
    .photoPicker: ("Photos", "photo"),
    .framePicker: ("Frames", "square.on.circle"),
    .stickerPicker: ("Stickers", "heart.circle"),
    .textPicker: ("Text", "textformat")
  ]
  let modal: CardModal
  var body: some View {
    if let text = modalButton[modal]?.text,
       let imageName = modalButton[modal]?.imageName {
      VStack {
        Image(systemName: imageName)
          .font(.largeTitle)
        Text(text)
      }
      .padding(.top)
    }
  }
}

struct CardBottomToolbar: View {
  @EnvironmentObject var viewState: ViewState
  @Binding var carModal: CardModal?
    var body: some View {
      HStack {
        Button(action: { carModal = .photoPicker }) {
          ToolbarButtonView(modal: .photoPicker)
        }
        Button(action: { carModal = .framePicker }) {
          ToolbarButtonView(modal: .framePicker)
        }.disabled(
          viewState.selectedElement == nil
          || !(viewState.selectedElement.self is ImageElement)
        )
        Button(action: { carModal = .stickerPicker }) {
          ToolbarButtonView(modal: .stickerPicker)
        }
        Button(action: { carModal = .textPicker }) {
          ToolbarButtonView(modal: .textPicker)
        }
      }
    }
}

struct CardBottomToolbar_Previews: PreviewProvider {
    static var previews: some View {
      CardBottomToolbar(carModal: .constant(.stickerPicker))
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
