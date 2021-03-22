import Combine
import SwiftUI
import PlaygroundSupport

let valuePerSecond = 1.0
let delayInSeconds = 1.5

let sourcePublisher = PassthroughSubject<Date,Never>()
let delayPublisher = sourcePublisher.delay(for: .seconds(delayInSeconds), scheduler: DispatchQueue.main)

let subscription = Timer.publish(every: 1.0 / valuePerSecond, on: .main, in: .common)
    .autoconnect()
    .subscribe(sourcePublisher);


let sourceTimelime = TimelineView(title: "Emitted value(\(valuePerSecond) per sec.):")
let delayedTimeline = TimelineView(title: "Delayed values(with a \(delayInSeconds)s delay):")

let view = VStack(spacing: 50){
    sourceTimelime
    delayedTimeline
}

PlaygroundPage.current.liveView = UIHostingController(rootView: view)


sourcePublisher.displayEvents(in: sourceTimelime)
delayPublisher.displayEvents(in: delayedTimeline)

//: [Next](@next)
/*:
 Copyright (c) 2019 Razeware LLC

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

