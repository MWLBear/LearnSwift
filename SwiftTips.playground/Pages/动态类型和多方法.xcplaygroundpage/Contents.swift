//: [Previous](@previous)

import Foundation

class Pet {}
class Cat : Pet {}
class Dog : Pet {}

func printPet(_ pet: Pet) {
    print("Pet")
}
func printPet(_ pet: Cat) {
    print("Cat")
}
func printPet(_ pet: Dog) {
    print("Dog")
}

printPet(Cat())
printPet(Dog())
printPet(Pet())


func printThem(_ pet: Pet,_ cat: Cat) {
    printPet(pet)
    printPet(cat)
}

printThem(Dog(), Cat())

//: [Next](@next)
