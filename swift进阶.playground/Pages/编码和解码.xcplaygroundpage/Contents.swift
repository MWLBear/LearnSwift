import Foundation
import CoreLocation
import UIKit

/**
将程序内部的数据结构序列化为一些可交换的数据格式，以及反过来将通用的数据格式反序列 化为内部使用的数据结构，这在编程中是一项非常常⻅的任务。Swift 将这些操作称为编码 (encoding) 和解码 (decoing)。
 
 Codable 系统
 
 → 普遍性-它对结构体，枚举和类都适用。
 → 类型安全-像是JSON这样的可交换格式通常都是弱类型，而你的代码应该要使用强类
 型数据。
 → 减少模板代码-在让自定义类型加入这套系统时，应该让开发者尽可能少地写重复的
 “适配代码”。编译器应该为你自动生成这些代码。
 
 */



//只要让你的类型满足 Codable 协议，它就能变为可编解码的类型。
struct Coordinate:Codable{
    var latitude:Double
    var longitude:Double
}

struct Placemark:Codable{
    var name:String
    var coordinate:Coordinate
}
//Encoding
//JSONEncoder
//PropertyListEncoder

//Encoder

let places = [
    Placemark(name: "Berlin", coordinate:
        Coordinate(latitude: 52, longitude: 13)),
    Placemark(name: "Cape Town", coordinate:
        Coordinate(latitude: -34, longitude: 18))
]

var jsonData:Data!

do{
    let encoder = JSONEncoder()
    jsonData = try encoder.encode(places)
    
    print(jsonData)
    let jsonstring = String(decoding: jsonData, as: UTF8.self)
    print(jsonstring)
    
    
    
}catch{
    print(error.localizedDescription)
}

do{
    let decoder = JSONDecoder()
    let decoded = try decoder.decode([Placemark].self, from: jsonData)
    // [Berlin (lat: 52.0, lon: 13.0), Cape Town (lat: -34.0, lon: 18.0)]
    type(of: decoded) // Array<Placemark>
  //  decoded == places // true
} catch {
    print(error.localizedDescription)
}

//编码过程
/**
 显然 Encoder 的核心功能就是提供一个编码容器。容器 是编码器存储的一种沙盒表现形式。
 通过为每个要编码的值创建一个新的容器，编码器能够确 保每个值都不会覆盖彼此的数据。
 
→ 键容器(KeyedContainer)可以对键值对进行编码。将键容器想像为一个特殊的字典， 到现在为止，这是最常⻅的容器
→ 无键容器(UnkeyedContainer)将对一系列值进行编码，而不需要对应的键，可以将它 想像成被编码值的数组。
→ 单值容器对一个单一值进行编码。你可以用它来处理整个数据被定义为单个属性的那类 类型。
 
 
 
 
 */

//值是如何对自己编码的

extension Array:Encodable where Element:Encodable{
    public func encode(to encoder:Encoder) throws{
        var container = encoder.unkeyedContainer()
        for element in self{
            try container.encode(element)
        }
    }
}

/**
 
 生成的代码
 
 Coding Keys
 首先，编译器会生成一个叫做 CodingKeys 的私有的嵌套枚举类型:这个枚举包含的成员与结构体中的存储属性一一对应
 编码器最后为了存储需要，还是必须要能将这些键转为字符串或者整数值。
 
 CodingKey 协议会负责这个转换任务:
 所有的键都必须提供一个字符串的表示，
 编译器生 成的默认代码只包含字符串键。
 
 encode(to:) 方法
 对于拥有 一个以上属性的组合数据结构 (比如结构体和类)，键容器是正确的选择。当需要一个键容器时， CodingKeys.self 将被传递给编码器。接下来将值编码到这个编码器中的编码命令中，都需要 指定一个该类型中的键。由于键类型通常都是嵌套在被编码类型中的私有类型，所以在这样的 设计下，手动实现该方法时不小心使用到另一个类型的编码键，是一件几乎不可能发生的事情。

 
 init(from:) 初始化方法
 ，使用 Decodable 中所定义的初始化方法为我们创建一个该类 型的实例。和编码器一样，解码器也管理一棵解码容器的树，树中所包含的容器我们已经很熟 悉了，它们还是键容器，无键容器，以及单值容器。
 每个被解码的值会以递归方式向下访问容器的层级，并且使用从容器中解码出来的值初始化对 应的属性。如果某个步骤发生了错误 (比如由于类型不匹配或者值不存在)，那么整个过程都会 失败，并抛出错误。

 //手动遵守协议
 手动遵守协议
 如果你有特殊的需求，可以通过实现 Encodable 和 Decodable 来进行满足。好的地方在于， 自动代码生成不是一件一锤子买卖的事儿，你可以选择你想要覆盖的部分，然后依然把剩下的 事情交给编译器来做。
 
 自定义 Coding Keys
 
 → 使用明确给定的字符串值，在编码后的输出中重命名字段，或者
 → 将某个键从枚举中移除，以此完全跳过字段。

 */

//想要给定一个另外的名字，我们需要明确将枚举的底层类型设置为 String
struct Placemark2: Codable {
    var name: String
    var coordinate: Coordinate
    private enum CodingKeys: String, CodingKey {
        case name = "label"
        case coordinate
    }
}

struct Placemark3: Codable {
    var name: String = "(Unknown)"
    var coordinate: Coordinate
    private enum CodingKeys: CodingKey {
        case coordinate
    }
}

//自定义的 encode(to:) 和 init(from:) 实现
 //你还可以对 encode(to:) 和/或 init(from:) 进行你自己的实现。作为例 子，我们会来看看解码器是如何处理可选值的
    
struct Placemark4: Codable {
    var name: String
    var coordinate: Coordinate?
}

    
//常见的编码任务
    
//让其他人的代码满足 Codable
struct Placemark5:Codable{
    
    var name:String
    var coordinate:CLLocationCoordinate2D
    
    private enum CodingKeys:String,CodingKey{
        case name
        case latitude = "lat"
        case longitude = "lon"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        //// 分别编码纬度和经度
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)

    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        
        self.coordinate = CLLocationCoordinate2D(
            latitude:try container.decode(Double.self, forKey: .latitude),
            longitude: try container.decode(Double.self, forKey: .longitude))
    }
    
}
//嵌套容器 另一种方案是使用嵌套容器来编码经纬度
//它能够 (使用另一套编码键类型) 另外创建一个键 容器。我们可以为这个嵌套键添加第二个枚举，然后将纬度和经度值编码到这个嵌套容器中去
struct Placemark6:Encodable{
    var name:String
    var coordinate:CLLocationCoordinate2D
    
    private enum CodingKeys:CodingKey{
        case name
        case coordinate
    }
    
    private enum CoordinateCodingKeys:CodingKey{
        case latitude
        case longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        var coordinateContainer = container.nestedContainer(keyedBy: CoordinateCodingKeys.self, forKey: .coordinate)
        try coordinateContainer.encode(coordinate.latitude, forKey: .latitude)
        try coordinateContainer.encode(coordinate.longitude, forKey: .longitude)
    }
}

//使用计算属性绕开问题

struct Placemark7: Codable {
    
    var name: String
    private var _coordinate: Coordinate
    var coordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2D(latitude: _coordinate.latitude,
                                          longitude: _coordinate.longitude) }
        set {
            _coordinate = Coordinate(latitude: newValue.latitude,
                                     longitude: newValue.longitude) }
    }
    private enum CodingKeys: String, CodingKey {
        case name
        case _coordinate = "coordinate"
    }
    
}

    
//让类满足 Codable
extension UIColor{
    
    var rgba:(red:CGFloat,green:CGFloat,blue:CGFloat,alpha:CGFloat)?{
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return (red:red,green:green,blue:blue,alpha:alpha)
        }else{
            return nil
        }
    }
    
}

extension UIColor{
    struct CodableWrapper:Codable {
        var value:UIColor
        init(_ value:UIColor) {
            self.value = value
        }
        enum CodingKeys:CodingKey {
            case red
            case green
            case blue
            case alpha
        }
        func encode(to encoder: Encoder) throws {
            guard let (red,green,blue,alpha) = value.rgba else{
                let errorContext = EncodingError.Context(
                    codingPath: encoder.codingPath,
                    debugDescription: "Unsupported color format: \(value)"
                )
                throw EncodingError.invalidValue(value, errorContext)
            }
            
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(red, forKey: .red)
            try container.encode(blue, forKey: .blue)
            try container.encode(green, forKey: .green)
            try container.encode(alpha, forKey: .alpha)

        }
        
        init(from decoder: Decoder) throws {
            
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let red = try container.decode(CGFloat.self, forKey: .red)
            let green = try container.decode(CGFloat.self, forKey: .green)
            let blue = try container.decode(CGFloat.self, forKey: .blue)
            let alpha = try container.decode(CGFloat.self, forKey: .alpha)
            self.value = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
}

let colors:[UIColor] = [
.red,
.white,
.init(displayP3Red: 0.5, green: 0.4, blue: 1.0, alpha: 0.8),
.init(hue: 0.6, saturation: 1.0, brightness: 0.8, alpha: 0.9)
]

let codableColors = colors.map(UIColor.CodableWrapper.init)

do{
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(codableColors)
    let jsonString = String(decoding: jsonData, as: UTF8.self)
    print(jsonString)
//[{"red":1,"alpha":1,"blue":0,"green":0},{"red":1,"alpha":1,"blue":1,"green":1},{"red":0.51923245191574097,"alpha":0.80000000000000004,"blue":1.0357813835144043,"green":0.39516723155975342},{"red":0,"alpha":0.90000000000000002,"blue":0.80000000000000004,"green":0.32000000000000028}]
} catch {
    print(error.localizedDescription)
}


struct ColoredRect: Codable {
    
    var rect: CGRect
    private var _color: UIColor.CodableWrapper
    
    var color:UIColor{
        get {return _color.value}
        set {_color.value = newValue}
    }
    init(rect:CGRect,color:UIColor) {
        self.rect = rect
        self._color = UIColor.CodableWrapper(color)
    }
    private enum CodingKeys:String,CodingKey{
        case rect
        case _color = "color"
    }
}

let rects = [ColoredRect(rect: CGRect(x: 10, y: 20, width: 100, height: 200), color: .yellow)]

do{
    let encoder = JSONEncoder()
    let jsonData = try encoder.encode(rects)
    let jsonString = String(decoding: jsonData, as: UTF8.self)
    print(jsonString)
    // [{"color":{"red":1,"alpha":1,"blue":0,"green":1},"rect":[[10,20],[100,200]]}]
} catch {
    print(error.localizedDescription)
}

//让枚举满足 Codable


enum Either<A:Codable,B:Codable>:Codable{
    
    case left(A)
    case right(B)
    
    private enum CodingKeys:CodingKey{
        case left
        case right
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .left(let value):
            try container.encode(value, forKey: .left)
        case .right(let value):
            try container.encode(value, forKey: .right)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let leftValue = try container.decodeIfPresent(A.self, forKey: .left) { // decodeIfPresent 来检查容器是否拥有左键
            self = .left(leftValue)
        }else{
            let rightValue = try container.decode(B.self, forKey: .right)
            self = .right(rightValue)
        }
    }
    
    
}

let values: [Either<String, Int>] = [
    .left("Forty-two"),
    .right(42)
]

do{
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let xmlData = try encoder.encode(values)
    
    let xmlString = String(decoding: xmlData, as: UTF8.self)
    print(xmlString)
    
    let decoder = PropertyListDecoder()
    let decoded = try decoder.decode([Either<String, Int>].self, from: xmlData)
    print(decoded)
    
}catch{
    print(error.localizedDescription)
}



