//
//  CardThumbnailView.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI

struct CardThumbnailView: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 15)
      .foregroundColor(.gray)
      .frame(width: 150, height: 250)
  }
}

struct CardThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        CardThumbnailView()
    }
}
