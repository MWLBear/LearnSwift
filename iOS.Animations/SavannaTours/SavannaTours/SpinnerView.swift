//
//  SpinnerView.swift
//  SavannaTours
//
//  Created by admin on 2021/4/29.
//

import SwiftUI

struct SpinnerView: View {
    
    struct Leaf: View {
        let rotation: Angle
        let isCurrent: Bool
        let isCompleting: Bool
        
        
        var body: some View {
            Capsule()
                .stroke(isCurrent ? Color.white : Color.gray,lineWidth: 8)
                .frame(width: 20, height: isCompleting ? 20 : 50)
                .offset(x:isCurrent ? 10 : 0, y: isCurrent ? 40 : 70)
                .scaleEffect(isCurrent ? 0.5 : 1.0)
                .rotationEffect(isCompleting ? .zero : rotation)
                .animation(.easeInOut(duration: 1.5))
        }
    }
    let leavesCount = 12
    @State var currenIndex: Int?
    @State var completed = false
    @State var isVisible = true
    @State var currentOffset = CGSize.zero
    let shootUp = AnyTransition.offset(CGSize(width: 0, height: -1000))
    
    var body: some View {
        VStack {
            if isVisible {
                ZStack {
                    ForEach(0..<leavesCount) { index in
                        Leaf(rotation: Angle(degrees: Double(index) / Double(self.leavesCount)) * 360,
                             isCurrent: index == self.currenIndex,
                             isCompleting: self.completed)
                    }
                }
                .offset(currentOffset)
                .blur(radius: currentOffset == .zero ? 0 : 10)
                .gesture(
                    DragGesture()
                        .onChanged({ gesrure in
                            self.currentOffset = gesrure.translation
                        })
                        .onEnded({ gesture in
                            if self.currentOffset.height > 150 {
                                self.complete()
                            }
                            self.currentOffset = .zero
                        })
                )
                .onAppear(perform:animate)
                .animation(.easeIn(duration: 1.0))
                .transition(shootUp)
                
            }
            
        }
    }
    func animate() {
        var iteration = 0
        Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
            if let current = self.currenIndex {
                self.currenIndex = (current + 1) % self.leavesCount
            }else {
                self.currenIndex = 0
            }
            iteration += 1
            if iteration == 60 {
                timer.invalidate()
                self.complete()
            }
        }
    }
    
    func complete() {
        guard !completed else { return }
        completed = true
        currenIndex = nil
        delay(seconds: 2) {
            self.isVisible = false
        }
    }
}

struct SpinnerView_Previews: PreviewProvider {
    static var previews: some View {
        SpinnerView()
    }
}
