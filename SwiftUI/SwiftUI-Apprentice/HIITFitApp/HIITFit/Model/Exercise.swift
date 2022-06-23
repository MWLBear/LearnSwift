//
//  Exercise.swift
//  HIITFit
//
//  Created by admin on 2022/6/14.
//

import Foundation
import SwiftUI
struct Exercise {
  let exerciseName: String
  let videoName: String
  enum ExerciseEnum: CustomStringConvertible {
    case squat
    case stepUp
    case burpee
    case sunSalut

    var description: String {
      switch self {
      case .squat:
        return NSLocalizedString("Squat", comment: "exercise")
      case .stepUp:
        return NSLocalizedString("Step Up", comment: "exercise")
      case .burpee:
        return NSLocalizedString("Burpee", comment: "exercise")
      case .sunSalut:
        return NSLocalizedString("Sun Salute", comment: "yoga stretch")
      }
    }
  }
}

extension Exercise {
  static let exercises = [
    Exercise(exerciseName: String(describing: ExerciseEnum.squat), videoName: "squat"),
    Exercise(exerciseName: String(describing: ExerciseEnum.stepUp), videoName: "step-up"),
    Exercise(exerciseName: String(describing: ExerciseEnum.burpee), videoName: "burpee"),
    Exercise(exerciseName: String(describing: ExerciseEnum.sunSalut), videoName: "sun-salute")
  ]
}
