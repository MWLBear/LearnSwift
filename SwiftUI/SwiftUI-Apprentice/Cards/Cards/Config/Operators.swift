//
//  Operators.swift
//  Cards
//
//  Created by admin on 2022/6/29.
//

import SwiftUI
func +(left: CGSize, right: CGSize) -> CGSize {
  CGSize(
    width: left.width + right.width,
    height: left.height + right.height)
}

func * (left: CGSize, right: CGFloat) -> CGSize {
  CGSize(
    width: left.width * right,
    height: left.height * right
  )
}

