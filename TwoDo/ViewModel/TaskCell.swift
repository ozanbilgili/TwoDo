//
//  TaskCell.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct TaskCell: View {
    @EnvironmentObject var taskStore: TaskStore
    var task: ToDo

    var body: some View {
        HStack {
            Button(action: {
                taskStore.toggleCompleted(task: task)
                taskStore.updateTask(task: task)
            }) {
                Image(systemName: !task.completed ? "circle" : "checkmark.circle.fill")
                    .foregroundColor(!task.completed ? .gray : .green)
            }
            .buttonStyle(BorderlessButtonStyle())
            
            VStack(alignment: .leading) {
                Text(task.name ?? "Unnamed task")
                    .font(.headline)
                Text(task.desc ?? "No description")
            }
            
            Spacer()
        }
    }
}


    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }

