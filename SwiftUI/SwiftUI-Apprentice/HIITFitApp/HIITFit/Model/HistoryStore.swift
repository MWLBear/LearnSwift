//
//  HistoryStore.swift
//  HIITFit
//
//  Created by admin on 2022/6/14.
//

import Foundation

struct ExerciseDay: Identifiable {
  let id = UUID()
  let date: Date
  var exercise: [String] = []
}

// An ObservableObject is a publisher, like Timer.publisher.
class HistoryStore: ObservableObject {
  // Whenever exerciseDays changes, it publishes itself to any subscribers, and the system redraws any affected views.
  @Published var exerciseDays: [ExerciseDay] = []
  enum FileError: Error {
    case loadFailure
    case saveFailure
    case urlFailure
  }
  init() {}
  init(withChecking: Bool) throws {
    print("Initializing HistoryStore")
    do {
      try load()
    } catch {
      throw error
    }
  }
  func addDoneExercise(_ exerciseName: String) {
    let today = Date()
    if let firstDate = exerciseDays.first?.date, today.isSameDay(as: firstDate) {
      print("Adding \(exerciseName)")
      exerciseDays[0].exercise.append(exerciseName)
    } else {
      exerciseDays.insert(ExerciseDay(date: today, exercise: [exerciseName]), at: 0)
    }
    print("Histroy:\(exerciseDays)")

    do {
      try save()
    } catch {
      print(error.localizedDescription)
    }
  }

  func load() throws {
    guard let dataURL = getURL() else {
      throw FileError.urlFailure
    }
    do {
      guard let data = try? Data(contentsOf: dataURL) else { return }
      let plistData = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
      let convertedPlistData = plistData as? [[Any]] ?? []
      exerciseDays = convertedPlistData.map {
        ExerciseDay(
          date: $0[1] as? Date ?? Date(),
          exercise: $0[2] as? [String] ?? [])
      }
    } catch {
      throw FileError.loadFailure
    }
  }
  func getURL() -> URL? {
    guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
      return nil
    }
    return documentURL.appendingPathComponent("history.plist")
  }

  func save() throws {
    guard let dataURL = getURL() else {
      throw FileError.urlFailure
    }
    let plisetData = exerciseDays.map {
      [$0.id.uuidString, $0.date, $0.exercise]
    }
    do {
      let data = try PropertyListSerialization.data(fromPropertyList: plisetData, format: .binary, options: .zero)
      try data.write(to: dataURL)
    } catch {
      throw FileError.saveFailure
    }
  }
}
