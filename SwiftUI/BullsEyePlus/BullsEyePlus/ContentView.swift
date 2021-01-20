
import SwiftUI
import Games

struct ContentView: View {
  @ObservedObject private var game = BullsEyeGame()

  @State private var currentValue = 50.0
  @State private var showAlert = false
  @EnvironmentObject var defaults: UserDefaults
    
  private var alpha: Double {
    abs(Double(game.targetValue) - currentValue) / 100.0
  }

  var body: some View {
    VStack {
      Text("Put the Bull's Eye as close as you can to: \(game.targetValue)")
      HStack {
        Text("0")
        if defaults.bool(forKey: "show_hint") {
            Slider(value: $currentValue, in: 1.0...100.0, step: 1.0)
              .background(Color.blue)
                .opacity(alpha)
        } else {
            Slider(value: $currentValue, in: 0.0...100.0, step: 1.0)
        }
        Text("100")
      }
      .padding(.horizontal)
      Button(action: {
        self.showAlert = true
        self.game.checkGuess(Int(self.currentValue))
      }) {
        Text("Hit Me!")
      }.alert(isPresented: $showAlert) {
        Alert(title: Text("Your Score"), message: Text(String(game.scoreRound)),
              dismissButton: .default(Text("OK"), action: {
                self.game.startNewRound()
                self.currentValue = 50.0
              }))
      }
      .padding()
      HStack {
        Text("Total Score: \(game.scoreTotal)")
        Text("Round: \(game.round)")
      }
    }
  }
}

struct ContentView_Previews : PreviewProvider {
  static var previews: some View {
    ContentView()
          .previewLayout(.fixed(width: 568, height: 320))
  }
}

