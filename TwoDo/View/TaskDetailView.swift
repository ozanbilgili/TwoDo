//
//  TaskDetailView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct TaskDetailView: View {
    @EnvironmentObject var taskStore: TaskStore
    @Environment(\.presentationMode) var presentationMode
    var task: ToDo
    @ObservedObject var taskEditor: TaskEditor
   


    var body: some View {
        Form {
            Section {
                TextField("Task Name", text: $taskEditor.name)
                TextField("Task Description", text: $taskEditor.desc)
                DatePicker("Deadline", selection: $taskEditor.deadline, displayedComponents: [.date, .hourAndMinute])
                TextField("Label", text: $taskEditor.label)
                Picker("Priority", selection: $taskEditor.priority) {
                    Text("Low").tag("Low")
                    Text("Normal").tag("Normal")
                    Text("High").tag("High")
                }
            }
            
            Section {
                Button(action: { saveChanges() }) {
                    Text("Save Changes")
                }
            }
        }
        .navigationTitle("Task Details")
    }

    private func saveChanges() {
        task.name = taskEditor.name
        task.desc = taskEditor.desc
        task.deadline = taskEditor.deadline
        task.label = taskEditor.label
        task.priority = taskEditor.priority
        task.completed = taskEditor.completed
        presentationMode.wrappedValue.dismiss()
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
}
