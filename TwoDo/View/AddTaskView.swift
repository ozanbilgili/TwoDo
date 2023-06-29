//
//  AddTaskView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var taskStore: TaskStore
    @Environment(\.presentationMode) var presentationMode
    @State private var id = UUID()
    @State private var name: String = ""
    @State private var desc: String = ""
    @State private var deadline: Date = Date()
    @State private var label: String = ""
    @State private var priority: String = "Normal"
    @State private var completed: Bool = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Task Name", text: $name)
                    TextField("Description", text: $desc)
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                    TextField("Label", text: $label)
                    Picker("Priority", selection: $priority) {
                        Text("Low").tag("Low")
                        Text("Normal").tag("Normal")
                        Text("High").tag("High")
                    }
                }
                
                Section {
                    Button(action: addTask, label: {
                        Text("Add Task")
                    })
                }
            }
            .navigationTitle("Add New Task")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addTask() {
        taskStore.addTask(name: name, desc: desc, deadline: deadline, label: label, priority: priority, completed: completed)
        presentationMode.wrappedValue.dismiss()
        print(completed)
    }
}
