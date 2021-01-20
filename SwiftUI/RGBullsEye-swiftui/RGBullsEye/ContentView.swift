//
//  ContentView.swift
//  RGBullsEye
//
//  Created by admin on 2021/1/13.
//

import SwiftUI
/**
 if the UI should update when its value changes, you designate a variable as a @State variable
 
 In SwiftUI, when a @State variable changes, the view invalidates its appearance and recomputes the body
 
 */

/**
 Guiding principles
 SwiftUI has two guiding principles for managing how data flows through your app:
 • Data access = dependency: Reading a piece of data in your view creates a dependency for that data in that view. Every view is a function of its data dependencies—its inputs or state.
 • Single source of truth: Every piece of data that a view reads has a source of truth, which is either owned by the view or external to the view. Regardless of where the source of truth lies, you should always have a single source of truth. This is why you didn't declare @State value in ColorSlider—it would have created a duplicate source of truth, which you'd have to keep in sync with rValue. Instead, you declared @Binding value, which means the view depends on a @State variable from another view.
 
 •数据访问=依赖关系：读取视图中的一条数据会为该视图中的数据创建依赖关系。 每个视图都是其数据依赖性（即输入或状态）的函数。
 •单一事实来源：视图读取的每条数据都有一个事实来源，该来源要么由视图拥有，要么位于视图外部。 无论真理的来源在哪里，您都应该始终有一个真实的来源。 这就是为什么您没有在ColorSlider中声明@State值的原因-它会创建一个真实的重复源，您必须与rValue保持同步。 相反，您声明了@Binding值，这意味着该视图依赖于另一个视图中的@State变量。
 
 
 特定于SwiftUI的包装器-@ State，@ Binding，@ ObservedObject和@EnvironmentObject-声明视图对变量表示的数据的依赖性。
 每个包装器指示不同的数据源：
 •@State变量归视图所有。 @State var分配持久性存储，因此您必须初始化其值。 Apple建议您将这些标记为私有，以强调@State变量专门由该视图拥有和管理。

 •@Binding声明依赖于另一个视图拥有的@State变量，该变量使用$前缀将对此状态变量的绑定传递给另一个视图。在接收视图中，@Binding var是对数据的引用，因此不需要初始化。此引用使视图可以编辑依赖于此数据的任何视图的状态。
 •@ObservedObject声明对符合ObservableObject协议的引用类型的依赖：它实现了objectWillChange属性以发布对其数据的更改。您很快将实现一个计时器作为ObservableObject。
 •@EnvironmentObject声明对某些共享数据的依赖关系-这些数据对于应用程序中的所有视图都是可见的。这是一种间接传递数据的简便方法，而不是将数据从父视图传递到子视图到孙子视图，尤其是在子视图不需要时。
 
 
 */


struct ContentView: View {
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    @State var rGuess:Double
    @State var gGuess:Double
    @State var bGuess:Double
    @State var showAlert = false
    @ObservedObject var timer = TimeCounter()
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff*rDiff + gDiff*gDiff + bDiff*bDiff)
        return Int((1-diff) * 100.0 + 0.5)
        
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        self.showAlert ? Text("R: \(Int(rTarget * 255.0))"
                            + " G: \(Int(gTarget * 255.0))"
                            + " B: \(Int(bTarget * 255.0))")
                            :Text("Mach this color")
                    }
                    VStack {
                        ZStack {
                            Color(red: rGuess, green: gGuess, blue: bGuess)
                            Text(String(timer.counter))
                                .padding(.all ,5)
                                .background(Color.white)
                                .mask(Circle())
                                .foregroundColor(.black)
                        }
                        Text("R: \(Int(rGuess * 255.0))"
                                + " G: \(Int(gGuess * 255.0))"
                                + " B: \(Int(bGuess * 255.0))")
                    }
                }
                
                Button(action: {
                    self.showAlert = true
                    self.timer.killTimer()
                }) {
                    Text("Hit me!")
                }.alert(isPresented: $showAlert, content: {
                    
                    Alert(title: Text("Your Score")
                          ,message: Text(String(computeScore())))
                    
                }).padding()
                
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }.padding(.horizontal)
            }
        } //.environment(\.colorScheme, .dark)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5).previewLayout(.fixed(width: 568, height: 320))
           
    }
}

struct ColorSlider: View {
    @Binding var value: Double
    var textColor: Color
    
    var body: some View {
        HStack {
            Text("0").foregroundColor(textColor)
            Slider(value: $value)
                .background(textColor)
                .cornerRadius(10)
                
               
            Text("255").foregroundColor(textColor)
        }
    }
}
