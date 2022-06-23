//
//  RatingView.swift
//  HIITFit
//
//  Created by admin on 2022/6/13.
//

import SwiftUI

struct RatingView: View {
  let exerciseIndex: Int
  @AppStorage("ratings") private var ratings = "0000"
  @State private var rating = 0
  let maxnumRating = 5
  let onColor = Color("ratings")
  let offColor = Color.gray
  func convertRating() {
    let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
    print(index)
    let character = ratings[index]
    rating = character.wholeNumberValue ?? 0
  }

  var body: some View {
    HStack {
      ForEach(1 ..< maxnumRating + 1) { index in
        Button {
          updateRating(index: index)
        } label: {
          Image(systemName: "waveform.path.ecg")
            .foregroundColor(
              index > rating ? offColor : onColor)
            .font(.body)
        }
        .buttonStyle(EmbossedButtonStyle())
        .onAppear {
          convertRating()
        }
        .onChange(of: ratings) { _ in
          convertRating()
        }
      }
    }
  }

  func updateRating(index: Int) {
    rating = index
    let index = ratings.index(ratings.startIndex, offsetBy: exerciseIndex)
    ratings.replaceSubrange(index...index, with: String(rating))
  }

  init(exerciseIndex: Int) {
    self.exerciseIndex = exerciseIndex
    let desiredLength = Exercise.exercises.count
    if ratings.count < desiredLength {
      ratings = ratings.padding(
        toLength: desiredLength,
        withPad: "0",
        startingAt: 0)
    }
  }
}

struct RatingView_Previews: PreviewProvider {
  @AppStorage("ratings") static var ratings: String?
  static var previews: some View {
    ratings = nil
    return RatingView(exerciseIndex: 0)
      .previewLayout(.sizeThatFits)
  }
}
