//
//  TaskEditor.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import SwiftUI

class TaskEditor: ObservableObject, Identifiable {
    @Published var id = UUID()
    @Published var name: String
    @Published var desc: String
    @Published var deadline: Date
    @Published var label: String
    @Published var priority: String
    @Published var completed: Bool
    

    init(task: ToDo) {
        
        self.name = task.name ?? ""
        self.desc = task.desc ?? ""
        self.deadline = task.deadline ?? Date()
        self.label = task.label ?? ""
        self.priority = task.priority ?? "Normal"
        self.completed = task.completed 
    }
}

