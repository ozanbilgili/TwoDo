//
//  TaskListView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var taskStore: TaskStore
    @Binding var filter: FilterType

    var body: some View {
        List {
            ForEach(taskStore.tasks.filter { shouldShow(task: $0) }, id: \.self) { task in
                let taskEditor = TaskEditor(task: task)
                NavigationLink(destination: TaskDetailView(task: task, taskEditor: taskEditor)) {
                    TaskCell(task: task)
                }
            }
            .onDelete(perform: deleteTasks)
        }
    }

    private func shouldShow(task: ToDo) -> Bool {
        switch filter {
        case .all:
            return true
        case .completed:
            return task.completed
        case .notCompleted:
            return !task.completed
        }
    }

    private func deleteTasks(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = taskStore.tasks[index]
            taskStore.deleteTask(task: task)
        }
    }
}
