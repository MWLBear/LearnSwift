//
//  ColorUISlider.swift
//  RGBullsEye
//
//  Created by admin on 2021/1/18.
//

/**
 关键点
 要将SwiftUI视图托管在UIKit项目中：
 1.将SwiftUI视图文件添加到您的项目。
 2.将托管控制器添加到情节提要中，并为其创建序列。
 3.在您的视图控制器代码中将segue连接到@IBSegueAction。
 4.将托管控制器的rootView设置为您的SwiftUI视图的实例。
 要将视图控制器托管在SwiftUI项目中：
 1.将视图控制器和情节提要文件添加到SwiftUI项目。
 2.在情节提要的身份检查器中，为视图控制器设置情节提要ID。
 3.为视图控制器创建一个表示结构，并实现makeUIViewController（context :)方法以从Main.storyboard实例化视图控制器。
 4.将NavigationLink添加到ContentView，并将视图控制器表示形式作为链接的目标。
 要托管具有数据依赖性的UIKit视图：
 1.创建一个符合UIViewRepresentable的SwiftUI视图。
 2.实现make方法以实例化UIKit视图。
 3.实现update方法，以从SwiftUI视图更新UIKit视图。
 4.创建一个协调器，并实现其valueChanged方法以从UIKit视图更新SwiftUI视图。
 
 
 
 */
import SwiftUI
import UIKit

struct ColorUISlider: UIViewRepresentable {
    
    var color: UIColor
    @Binding var value: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = color
        slider.value = Float(value)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }
    func updateUIView(_ view: UISlider, context: Context) {
        view.value = Float(self.value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value)
    }
    
    class Coordinator: NSObject {
       
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        @objc func valueChanged(_ sender: UISlider) {
            print("value:\(sender.value)")
            
            self.value.wrappedValue =  Double(sender.value)
        }
    }

}

struct ColorUISlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorUISlider(color: .red, value: .constant(0.5))
    }
}

