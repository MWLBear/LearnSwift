//
//  ViewController.swift
//  小组件
//
//  Created by admin on 2021/10/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let lael = UILabel()
        lael.backgroundColor = .red
        lael.center = view.center
        lael.text = "每日一拍"
        lael.sizeToFit()
       
        self.view.addSubview(lael)
        
        let color = cxg_getPointColor(withImage: UIImage(named: "bg")!, point: CGPoint(x: 0, y: 40))
      
        print(color)
        print(UIColor.white)
        lael.textColor = color
    }


    
    func cxg_getPointColor(withImage image: UIImage, point: CGPoint) -> UIColor? {

        guard CGRect(origin: CGPoint(x: 0, y: 0), size: image.size).contains(point) else {
            return nil
        }

        let pointX = trunc(point.x);
        let pointY = trunc(point.y);

        let width = image.size.width;
        let height = image.size.height;
        let colorSpace = CGColorSpaceCreateDeviceRGB();
        var pixelData: [UInt8] = [0, 0, 0, 0]

        pixelData.withUnsafeMutableBytes { pointer in
            if let context = CGContext(data: pointer.baseAddress, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue), let cgImage = image.cgImage {
                context.setBlendMode(.copy)
                context.translateBy(x: -pointX, y: pointY - height)
                context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            }
        }

        let red = CGFloat(pixelData[0]) / CGFloat(255.0)
        let green = CGFloat(pixelData[1]) / CGFloat(255.0)
        let blue = CGFloat(pixelData[2]) / CGFloat(255.0)
        let alpha = CGFloat(pixelData[3]) / CGFloat(255.0)

        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
        } else {
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }

   
}

