//
//  TimerView.swift
//  HIITFit
//
//  Created by admin on 2022/6/14.
//

import SwiftUI

struct TimerView: View {
  @Environment(\.presentationMode) var presentationMode
  @State private var timeRemaining = 3
  @Binding var timeDone: Bool
  let exerciseName: String
  let timer = Timer.publish(every: 1, on: .main, in: .common)
    .autoconnect()
  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Color("background")
          .edgesIgnoringSafeArea(.all)
        circle(size: geometry.size)
          .overlay(
            GradientBackground()
              .mask(circle(size: geometry.size))
          )
        VStack {
          Text(exerciseName)
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.white)
            .padding(.top, 20)
          Spacer()
          IndentView {
            timerText
          }
          Spacer()
          RaiseButton(buttonText: "Done") {
            presentationMode.wrappedValue.dismiss()
          }
          .opacity(timeDone ? 1 : 0)
          .padding([.trailing, .leading], 30)
          .padding(.bottom, 60)
          .disabled(!timeDone)
        }
        .onAppear {
          timeDone = false
        }
      }
    }
  }

  var timerText: some View {
    Text("\(timeRemaining)")
      .font(.system(size: 90, design: .rounded))
      .fontWeight(.heavy)
      .frame(
        minWidth: 180,
        maxWidth: 200,
        minHeight: 180,
        maxHeight: 200)
      .padding()
      .onReceive(timer) { _ in
        if self.timeRemaining > 0 {
          self.timeRemaining -= 1
        } else {
          timeDone = true
        }
      }
  }

  func circle(size: CGSize) -> some View {
    Circle()
      .frame(
        width: size.width,
        height: size.height)
      .position(
        x: size.width * 0.5,
        y: -size.width * 0.2)
  }
}

struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView(
      timeDone: .constant(false),
      exerciseName: "Step Up")
      .previewLayout(.sizeThatFits)
  }
}
