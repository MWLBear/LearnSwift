//
//  ViewExtensions.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI
extension View {
  func resizableView(transform: Binding<Transform>) -> some View {
    return modifier(ResizableView(transform: transform))
  }
}
