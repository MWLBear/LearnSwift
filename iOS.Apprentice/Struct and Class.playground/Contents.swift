import UIKit
/**
 Classes are reference types
 When you assign an instance of a class to a variable or constant, that variable or constant doesn’t contain the instance itself. Instead, it contains a reference to the instance. Think of references as being like someone’s email address — it’s not the person, but a way to reach that person.
 类是引用类型
 当您将类别的实例指派给变数或常数时，该变数或常数并不包含该实例本身。 相反，它包含对实例的引用。 将引用视为某人的电子邮件地址，这不是该人，而是联系该人的一种方式。
 
 结构是值类型
 结构和类之间的真正区别是，虽然类是引用类型，但结构是值类型。 将结构实例分配给变量时，就是将结构放入该变量中，而不是对该结构的引用。
 
 */
class CatClass {
    var name:String
    var weight:Double
    
    init(name:String,weight:Double) {
        self.name = name
        self.weight = weight
    }
    func report() {
        print("\(name) weighs \(weight) kilograms.")
    }
    func fatten() {
        print("Fattening \(name)...")
        weight += 0.5
        report()
    }
    
}
var classCat1 = CatClass(name: "Ani", weight: 2.5)
classCat1.name = "Esmerelda"
let classCat2 = CatClass(name: "Bao", weight: 6.3)
classCat2.name = "Faiza"
classCat1.fatten()
classCat2.fatten()


var classCat3 = CatClass(name: "Imelda", weight: 6.1)
var classCat4 = CatClass(name: "Jasmine", weight: 2.2)
classCat3.report()
classCat4.report()

classCat4 = classCat3
classCat3.report()
classCat4.report()


classCat3.name = "Kenji"
classCat3.report()
classCat4.report()

classCat4.fatten()
classCat3.report()
classCat4.report()

class RoboCat: CatClass {
    var laserEnergy:Int
    init(name:String, weight:Double,laserEnergy:Int) {
        self.laserEnergy = laserEnergy
        super.init(name: name, weight: weight)
    }
    func fireLaser() {
        if laserEnergy > 0 {
            print("\(name) fires a laser. Pew! Pew!")
            laserEnergy -= 1
        }else {
            print("No energy to fire laser.")
        }
    }
    override func report() {
        print("\(name) weighs \(weight) kilograms and has \(laserEnergy) units of laser energy.")
    }
}

let classCat5 = RoboCat(name: "FELINE SECURITY UNIT", weight: 20.0, laserEnergy: 10)
classCat5.fireLaser()
classCat5.fatten()

struct CatStruct {
    var name:String
    var weight:Double
    
    func report() {
        print("\(name) weighs \(weight) kilograms.")
    }
    mutating func fatten() {
        print("Fattening \(name)...")
        weight += 0.5
        report()
    }
}

var structCat1 = CatStruct(name: "Latifah", weight: 3.9)
structCat1.name = "Mongo"
structCat1.weight = 10.0 // Mongo likes candy!
structCat1.weight += 0.5
structCat1.report()
structCat1.fatten()

var structCat2 = structCat1
structCat2.report()
structCat2.name = "Naveen"
structCat2.weight = 5.3
structCat1.report()
structCat2.report()

//let structCat3 = CatStruct(name: "Orson", weight: 5.5)
//structCat3.fatten()
protocol Pet {
    var name: String { get set }
    var weight: Double { get set }
    func report() -> ()
    mutating func fatten() -> ()
}

struct ProtocolCat:Pet {
    var name: String
    var weight: Double
}

extension Pet {
    func report() {
        print("\(name) weighs \(weight) kilograms.")
    }
    mutating func fatten() {
        print("Fattening \(name)...")
        weight += 0.5
        report()
    }
}

var structCat4 = ProtocolCat(name: "Pasquale", weight: 7.7)
structCat4.report()
structCat4.fatten()

struct Dog:Pet {
    var name: String
    var weight: Double
    func fetch() {
       print("You throw a ball, and \(name) gets it and brings it back to you.")
   }
}
var myDog = Dog(name: "Quincy", weight: 9.4)
myDog.report()
myDog.fatten()
myDog.fetch()
protocol LaserEquipped {
    var laserEnergy: Int { get set }
    mutating func fireLaser() -> ()
}
extension LaserEquipped {
    mutating func fireLaser() {
        if laserEnergy > 0 {
            print("Firing laser. Pew! Pew!")
            laserEnergy -= 1
        } else {
            print("No energy to fire laser.") }
    }
}
struct LaserCat: Pet, LaserEquipped {
  var name: String
  var weight: Double
  var laserEnergy: Int
}
var laserKitty = LaserCat(name: "Renoir", weight: 20.0, laserEnergy: 20)
laserKitty.report()
laserKitty.fatten()
laserKitty.fireLaser()

struct LaserDog: Pet, LaserEquipped {
    var name: String
    var weight: Double
    var laserEnergy: Int
    func fetch() {
        print("You throw a ball, and \(name) gets it and brings it back to you.")
    }
}
var laserPuppy = LaserDog(name: "Salieri", weight: 20.0, laserEnergy: 20)
laserPuppy.report()
laserPuppy.fatten()
laserPuppy.fireLaser()
laserPuppy.fetch()

struct Hamster: Pet {
    var name: String
    var weight: Double
    var isOnHamsterWheel: Bool
    func report() {
        let wheelStatus = isOnHamsterWheel ? "on" : "not on"
        print("\(name) weighs \(weight) kilograms, and is \(wheelStatus) its hamster wheel.")
    }
}

var myHamster = Hamster(name: "Tetsuo", weight: 0.1, isOnHamsterWheel: true)
myHamster.report()
