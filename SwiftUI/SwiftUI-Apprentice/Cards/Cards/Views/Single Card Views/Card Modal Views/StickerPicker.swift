//
//  StickerPicker.swift
//  Cards
//
//  Created by admin on 2022/7/14.
//

import SwiftUI

struct StickerPicker: View {
  @State private var stickerNames: [String] = []
  @Binding var stickerImage: UIImage?
  @Environment(\.presentationMode) var presentationMode
  let columns = [
    GridItem(.adaptive(minimum: 120), spacing: 0)
  ]
    var body: some View {
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(stickerNames,id: \.self) { sticker in
            Image(uiImage: image(from: sticker))
              .resizable()
              .aspectRatio( contentMode: .fit)
              .onTapGesture {
                stickerImage = image(from: sticker)
                presentationMode.wrappedValue.dismiss()
              }
          }
        }
      }
      .onAppear {
        stickerNames = loadStickers()
      }
    }

  func loadStickers() -> [String] {
    var themes: [URL] = []
    var stickerNames: [String] = []
    let fileManager = FileManager.default
    if let resourcePath = Bundle.main.resourcePath,
       let enumerator = fileManager.enumerator(
        at: URL(fileURLWithPath: resourcePath + "/Stickers"),
        includingPropertiesForKeys: nil,
        options:[.skipsHiddenFiles, .skipsSubdirectoryDescendants]
       )
    {
      for case let url as URL in enumerator
      where url.hasDirectoryPath {
        themes.append(url)
      }
    }
    for theme in themes {
      if let files = try? fileManager.contentsOfDirectory(atPath: theme.path) {
        for file in files {
          stickerNames.append(theme.path + "/" + file)
        }
      }
    }
    return stickerNames
  }

  func image(from path: String) -> UIImage {
    print("loading: \(path)")
    return UIImage(named: path)
    ?? UIImage(named: "error-image")
    ?? UIImage()
  }
}

struct StickerPicker_Previews: PreviewProvider {
    static var previews: some View {
      StickerPicker(stickerImage: .constant(UIImage()))
        .previewLayout(PreviewLayout.fixed(width: 896, height: 414))
    }
}
