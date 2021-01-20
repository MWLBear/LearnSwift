//
//  UISlider.swift
//  BullsEye
//
//  Created by admin on 2021/1/19.
//

import SwiftUI
import UIKit

struct ColorUISlider: UIViewRepresentable {
    
    var color: UIColor
    @Binding var value: Double
    @Binding var alpha: Double
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.minimumValue = 1.0
        slider.maximumValue = 100.0
        slider.thumbTintColor = color.withAlphaComponent(CGFloat(alpha))
        slider.value = Float(value)
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChange(_:)), for: .valueChanged)
        return slider
        
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.alpha = CGFloat(self.alpha)
        uiView.value = Float(self.value)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(value: $value, alpha: $alpha)
    }
    
    
    
    class Coordinator: NSObject {
        
        var value: Binding<Double>
        var alpha: Binding<Double>
        
        init(value: Binding<Double>, alpha: Binding<Double>){
            self.value = value
            self.alpha = alpha
        }
        
        @objc func valueChange(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
            self.alpha.wrappedValue = Double(sender.alpha)
        }
    }
}

struct UISlider_Previews: PreviewProvider {
    static var previews: some View {
        ColorUISlider(color: .blue, value: .constant(50), alpha: .constant(0.5))
    }
}
