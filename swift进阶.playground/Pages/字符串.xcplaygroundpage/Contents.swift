import Foundation


/**
 Swift 中的 String 是 Character 值的集合，
 
  Unicode 是一个可变⻓格式。它的可变⻓特性有两种不同的意义:
 由编码单元 (code unit) 组成 Unicode 标量 (Unicode scalar);由 Unicode 标量组成字符。
 
 
 Unicode 数据可以被编码成许多不同宽度的编码单元，最普遍的使用的是 8 比特 (UTF-8) 或者 16 比特 (UTF-16) 。
 UTF-8 额外的优势在于可以向后兼容 8 比特的 ASCII。
 
 
 Unicode 中的编码点 (code point) 在 Unicode 编码空间中是介于 0 到 0x10FFFF (也就是十进 制的 1,114,111) 之间的一个单一值。
 对于 UTF-32，一个编码点会占用一个编 码单元。对于 UTF-8 一个编码点会占用一至四个编码单元。起始的 256 个 Unicode 编码点和 Latin-1 中的字符是一致的。
 
 Unicode 标量和编码点在大部分情况下是同样的东西。除了在 0xD800–0xDFFF 之间范围里的 2,048 个 “代理” (surrogate) 编码点 (它们被用来标示成对的 UTF-16 编码的开头或者结尾) 之 外的所有编码点，都是 Unicode 标量
 
 
 在 Unicode 中，这种从用戶视⻆看到的字符有一个术 语，它叫做扩展字位簇 (extended grapheme cluster)。
 
 */

let c = "\u{20AC}"
//标准等价 (canonically equivalent)。
let single = "Pok\u{00E9}mon" // Pokémon
let double = "Poke\u{0301}mon" // Pokémon
(single,double)

single.count
double.count
single == double

single.utf16.count
double.utf16.count

let chars: [Character] = [
    "\u{1ECD}\u{300}", // ọ́
    "\u{F2}\u{323}", // ọ́
    "\u{6F}\u{323}\u{300}", // ọ́
    "\u{6F}\u{300}\u{323}" //ọ́
]
let oneEmoji = "😄"
oneEmoji.count

let flags = "🇨🇳🇺🇸"
flags.count
flags.unicodeScalars.map{
    "U+\(String($0.value,radix: 16,uppercase: true))"
}

let skinTone = "👧🏽"

//将 Unicode 标量转换为它们 对应的官方 Unicode 名字:
extension StringTransform{
    static let toUnicodeName = StringTransform(rawValue: "Any-Name")
}
extension Unicode.Scalar{
    var unicodeName:String{
        let name = String(self).applyingTransform(.toUnicodeName, reverse: false)!
        let prefixPattern = "\\N{"
        let suffixPattern = "}"
        let prefixLength = name.hasPrefix(prefixPattern) ? prefixPattern.count : 0
        let suffixLength = name.hasSuffix(suffixPattern) ? suffixPattern.count : 0
        return String(name.dropFirst(prefixLength).dropLast(suffixLength))
    }
    
}
let sk = skinTone.unicodeScalars.map { $0.unicodeName }
print(sk)
let flagLetterC = "🇨"
let flagLetterN = "🇳"
let flag = flagLetterC+flagLetterN

var greeting = "Hello,world!"
if let comma = greeting.index(of: ",") {
    greeting[..<comma]
    greeting.replaceSubrange(comma..., with: " again.")
}
greeting

//因为整数的下标访问无法在常数时间内完成 (对于 Collection 协议 来说这也是个直观要求)，而且查找第 n 个 Character 的操作也必须要对它之前的所有字节进行 检查。

let s = "abcdef"
let second = s.index(after: s.startIndex)
s[second]
let sixth = s.index(second, offsetBy: 4)
s[sixth] // f
let safeIdx = s.index(s.startIndex, offsetBy: 400, limitedBy: s.endIndex)
safeIdx // nil
s.prefix(4)
for (i, c) in "hello".enumerated() {
    print("\(i): \(c)")
}

var hello = "hello!"
if let idx = hello.index(of: "!") {
    hello.insert(contentsOf: ",World", at: idx)
}
hello

let lowercaseLetters = ("a" as Character)..."z"
lowercaseLetters.contains("é") // true
//for c in lowcaseLetters{
//    print(c)
//}

//String 和 Character 的内部结构



