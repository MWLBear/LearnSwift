import Foundation

struct UserStory {
  // MARK: - Value Types
  enum Username: String {
    case swift, android, dog
    var events: [StoryEvent] {
      let events: [StoryEvent]
      switch self {
      case .swift:
        events = [
          StoryEvent(
            title: "Experimenting with the latest technologies...",
            image: #imageLiteral(resourceName: "swift_experimenting")),
          StoryEvent(
            title: "Exploring the sky...",
            image: #imageLiteral(resourceName: "android")),
          StoryEvent(
            title: "Teaching data structures and algorithms...",
            image: #imageLiteral(resourceName: "swift_teaching"))]
      case .android:
        events = [
          StoryEvent(
            title: "Constructing learning facilities...",
            image: #imageLiteral(resourceName: "android_construction")),
          StoryEvent(
            title: "Hanging out with Swift...",
            image: #imageLiteral(resourceName: "android_hanging_out_with_swift")),
          StoryEvent(
            title: "Lecturing a class on adaptive layouts...",
            image: #imageLiteral(resourceName: "android_teaching_diagram"))
        ]
      case .dog:
        events = [
          StoryEvent(
            title: "Being a bouncer...",
            image: #imageLiteral(resourceName: "dog_bouncer")),
          StoryEvent(
            title: "Basketball training...",
            image: #imageLiteral(resourceName: "dog_basketball")),
          StoryEvent(
            title: "Meditating...",
            image: #imageLiteral(resourceName: "dog_yoga"))
        ]
      }
      return events
    }
  }
  // MARK: - Properties
  let username: Username
  let events: [StoryEvent]
  
  // MARK: - Initializers
  init(username: Username) {
    self.username = username
    events = username.events
  }
}
