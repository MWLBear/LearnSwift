//
//  ExerciseView.swift
//  HIITFit
//
//  Created by admin on 2022/6/13.
//

import AVKit
import SwiftUI

struct ExerciseView: View {
  @EnvironmentObject var history: HistoryStore
  // The property wrapper @AppStorage will save any changes to rating to UserDefaults
  @Binding var selectedTab: Int
  @State private var timerDone = false

  @State private var showSuccess = false
  @State private var showSheet = false
  @State private var showTimer = false
  @State private var showHistory = false

  @State private var exerciseSheet: ExerciseSheet?
  let index: Int
  enum ExerciseSheet {
    case history, timer, sucess
  }

  var lastExcercise: Bool {
    return index + 1 == Exercise.exercises.count
  }
  var body: some View {
    GeometryReader { geometry in
      VStack {
        HeaderView(selectedTab: $selectedTab, titleText: Exercise.exercises[index].exerciseName)
          .padding(.bottom)
        ContainerView {
          VStack {
            video(size: geometry.size)
            startExerciseButton
              .padding(20)
            RatingView(exerciseIndex: index)
              .padding()
            Spacer()
            historyButton
          }
        }
        .frame(height: geometry.size.height * 0.8)
        .sheet(isPresented: $showSheet) {
          showSuccess = false
          showHistory = false
          if exerciseSheet == .timer {
            if timerDone {
              history.addDoneExercise(Exercise.exercises[index].exerciseName)
              timerDone = false
            }
            showTimer = false
            if lastExcercise {
              showSuccess = true
              showSheet = true
              exerciseSheet = .sucess
            } else {
              selectedTab += 1
            }
          } else {
            exerciseSheet = nil
          }
          showTimer = false
        } content: {
          if let exerciseSheet = exerciseSheet {
            switch exerciseSheet {
            case .history:
              HistoryView(showHistory: $showHistory)
                .environmentObject(history)
            case .timer:
              TimerView(timeDone: $timerDone, exerciseName: Exercise.exercises[index].exerciseName)
            case .sucess:
              SuccessView(selectedTab: $selectedTab)
            }
          }
        }
      }
    }
  }

  @ViewBuilder
  func video(size: CGSize) -> some View {
    if let url = Bundle.main.url(
      forResource: Exercise.exercises[index].videoName,
        withExtension: "mp4") {
      VideoPlayer(player: AVPlayer(url: url))
        .frame(height: size.height * 0.25)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(20)
    } else {
      Text(
        "Couldn't find \(Exercise.exercises[index].videoName).mp4")
        .foregroundColor(.red)
    }
  }

  var startExerciseButton: some View {
    RaiseButton(buttonText: "Start Exercise") {
      showTimer.toggle()
      showSheet = true
      exerciseSheet = .timer
    }
  }
  var historyButton: some View {
    Button {
      showSheet = true
      showHistory = true
      exerciseSheet = .history
    } label: {
      Text("History")
        .fontWeight(.bold)
        .padding([.leading, .trailing], 5)
    }
    .padding(.bottom, 10)
    .buttonStyle(EmbossedButtonStyle())
  }
}

struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(selectedTab: .constant(0), index: 0)
      .environmentObject(HistoryStore())
  }
}
