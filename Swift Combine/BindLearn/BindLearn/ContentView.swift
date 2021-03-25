//
//  ContentView.swift
//  BindLearn
//
//  Created by admin on 2021/3/25.
//

import SwiftUI
import Combine

struct Person: Identifiable {
    let id: UUID
    var name: String
    var age: Int
}

final class PersonStore: ObservableObject {
    @Published var persons: [Person] = [
        .init(id: .init(), name: "Majid", age: 28),
        .init(id: .init(), name: "John", age: 31),
        .init(id: .init(), name: "Fred", age: 25)
    ]
}

struct ContentView: View {
    let store = PersonStore()
    
    var body: some View {
        
        PersonsView(store: store)
    }
}

struct PersonsView : View {
    @ObservedObject var store: PersonStore

    var body: some View {
        NavigationView {
            List {
                ForEach(store.persons.indexed(), id: \.1.id) { index, person in
                    NavigationLink(destination: EditingView(person: self.$store.persons[index])) {
                        VStack(alignment: .leading) {
                            Text(person.name)
                                .font(.headline)
                            Text("Age: \(person.age)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }.navigationBarTitle(Text("Persons"))
        }
    }
}
struct EditingView: View {
    @Environment(\.presentationMode) var presentation
    @Binding var person: Person

    var body: some View {
        Form {
            Section(header: Text("Personal information")) {
                TextField("type something...", text: $person.name)
                Stepper(value: $person.age) {
                    Text("Age: \(person.age)")
                }
            }

            Section {
                Button("Save") {
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }.navigationBarTitle(Text(person.name))
    }
}
extension Sequence {
    func indexed() -> Array<(offset: Int, element: Element)> {
        return Array(enumerated())
    }
}
