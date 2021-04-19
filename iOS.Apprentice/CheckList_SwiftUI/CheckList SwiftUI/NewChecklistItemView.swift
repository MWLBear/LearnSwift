//
//  NewChecklistItemView.swift
//  CheckList SwiftUI
//
//  Created by admin on 2021/4/19.
//

import SwiftUI
//@Environment将一个属性标记为可以访问操作系统环境的特定系统设置（即名称）的属性
//@Environment marks a property as one that can access a specific system setting of the operating system environment, hence the name
//@Environment后面的括号的内容以\。开头，您已经在前面看到过-它是一个KeyPath，它是对对象（在本例中为Environment对象）的属性的引用，而不是对对象本身的引用。

struct NewChecklistItemView: View {
    var checklist: Checklist
    @State var newItemName = ""
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Text("Add new item")
            Form {
                TextField("Enter new item name here", text: $newItemName)
                Button(action: {
                    let item = ChecklistItem(name: self.newItemName)
                    self.checklist.items.append(item)
                    self.checklist.printChecklistContents()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add new item")
                    }
                }).disabled(newItemName.count == 0)
            }
            Text("Swipe dowm to cancle")
        }.onAppear {
            print("NewChecklistItemView has appeared!")
          }
          .onDisappear {
            print("NewChecklistItemView has disappeared!")
          }
    }
}

struct NewChecklistItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewChecklistItemView(checklist: Checklist())
    }
}
