//
//  ContentView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var taskStore = TaskStore()
    @State private var filter: FilterType = .all
    @State private var showingAddTaskView = false

    var body: some View {
        NavigationView {
            TaskListView(filter: $filter)
                .environmentObject(taskStore)
                .navigationBarItems(
                    leading: Button(action: {
                        showingAddTaskView = true
                    }) {
                        Image(systemName: "plus")
                    },
                    trailing: FilterView(filter: $filter)
                )
                .navigationTitle("TwoDo")
                .sheet(isPresented: $showingAddTaskView) {
                    AddTaskView()
                        .environmentObject(taskStore)
                }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
