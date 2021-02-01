

import SwiftUI

struct FirstVisitAward: View {
    var body: some View {
        
        
        GeometryReader { geomerty in
            ZStack {
                ForEach(0..<3){ i in
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: .init(colors: [Color.green, Color.blue]),
                                startPoint: .init(x: 0, y: 1),
                                endPoint: .init(x: 1, y: 0)
                            )
                        )
                        .frame(width: geomerty.size.width * 0.7,
                               height: geomerty.size.height * 0.7)
                        .rotationEffect(.degrees(Double(i) * 60.0))
                }
                Image(systemName: "airplane")
                    .resizable()
                    .rotationEffect(.degrees(-90))
                    .opacity(0.5)
                    .scaleEffect(0.7)
            }
        }
            
            
    }
}

struct FirstVisitAward_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstVisitAward()
                .environment(\.colorScheme, .light)
                .frame(width: 200, height: 200)
            
           FirstVisitAward()
            .environment(\.colorScheme, .dark)
            .frame(width: 200, height: 200)

        }

    }
}
