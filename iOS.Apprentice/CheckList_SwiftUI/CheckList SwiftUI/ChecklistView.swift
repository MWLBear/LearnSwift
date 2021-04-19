//
//  ContentView.swift
//  CheckList SwiftUI
//
//  Created by admin on 2021/4/16.
//

import SwiftUI



struct ChecklistView: View {
    // Properties
    // ==========
    @ObservedObject var checklist = Checklist()
    @State var newChecklistItemViewIsVisible = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(checklist.items){index in
                    RowView(checklistItem: self.$checklist.items[index])
                }
                .onDelete(perform: checklist.deleteListItem)
                .onMove(perform: checklist.moveListItem)
            }
            .navigationBarItems(leading: Button(action: { self.newChecklistItemViewIsVisible = true}, label: {
                HStack {
                    Image(systemName:"plus.circle.fill")
                    Text("Add item")
                }
            }),trailing: EditButton())
            .navigationBarTitle("Checklist",displayMode: .inline)
        }.sheet(isPresented: $newChecklistItemViewIsVisible, content: {
            NewChecklistItemView(checklist: checklist)
        }).onAppear{
            print("ChecklistView onAppear")
        }.onDisappear{
            print("ChecklistView onDisappear")
        }.onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            self.checklist.saveChecklistItems()
        }).onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) {_ in
            print("didEnterBackgroundNotification")
          }
          .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) {_ in
            print("willEnterForegroundNotification")
          }.onReceive(NotificationCenter.default.publisher(for:UIApplication.didBecomeActiveNotification)) {  _ in
            print("didBecomeActiveNotification")
          }
    }
    
    // Methods
    // =======
   
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChecklistView()
    }
}
