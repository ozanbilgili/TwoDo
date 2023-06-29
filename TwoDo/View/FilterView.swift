//
//  FilterView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct FilterView: View {
    @Binding var filter: FilterType
    
    var body: some View {
        Picker("Filter", selection: $filter) {
            Text("All").tag(FilterType.all)
            Text("Completed").tag(FilterType.completed)
            Text("Incomplete").tag(FilterType.notCompleted)
        }
        .pickerStyle(MenuPickerStyle())
        .padding()
    }
}

enum FilterType {
    case all
    case completed
    case notCompleted
}
