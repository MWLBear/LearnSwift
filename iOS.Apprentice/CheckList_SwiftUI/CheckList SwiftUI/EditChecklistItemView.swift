//
//  EditChecklistItemView.swift
//  CheckList SwiftUI
//
//  Created by admin on 2021/4/19.
//

import SwiftUI

struct EditChecklistItemView: View {
    @Binding var checklistItem: ChecklistItem
    var body: some View {
        Form {
            TextField("Name", text: $checklistItem.name)
            Toggle("Completed", isOn: $checklistItem.isChecked)
        }.onAppear{
            print("EditChecklistItemView onAppear")
        }.onDisappear{
            print("EditChecklistItemView onDisappear")
        }
    }
}


