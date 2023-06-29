//
//  SwiftUIView.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 19.06.2023.
//

import Foundation
import CoreData
import SwiftUI
import UserNotifications

class TaskStore: ObservableObject {
    @Published var tasks: [ToDo] = []
    
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ToDoModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading CoreData stores: \(error)")
            }
        }
        requestNotificationAuthorization()
        fetchTasks()
    }


    func fetchTasks() {
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()

        do {
            tasks = try container.viewContext.fetch(fetchRequest)
        } catch {
            print("Failed to fetch tasks: \(error)")
        }
    }

    func addTask(name: String, desc: String, deadline: Date, label: String, priority: String, completed: Bool) {
        let newTask = ToDo(context: container.viewContext)
        newTask.name = name
        newTask.desc = desc
        newTask.deadline = deadline
        newTask.label = label
        newTask.priority = priority
        newTask.completed = completed

        do {
            try container.viewContext.save()
            fetchTasks()
            scheduleNotification(for: newTask)
        } catch {
            print("Error saving new task: \(error)")
        }
    }

    func updateTask(task: ToDo) {
        do {
            try container.viewContext.save()
            fetchTasks()
            scheduleNotification(for: task)
            print("Save")
        } catch {
            print("Error updating task: \(error)")
        }
    }

    func deleteTask(task: ToDo) {
        container.viewContext.delete(task)
        
        do {
            try container.viewContext.save()
            fetchTasks()
        } catch {
            print("Error deleting task: \(error)")
        }
    }
    
    func toggleCompleted(task: ToDo) {
            guard let taskIndex = tasks.firstIndex(where: { $0.id == task.id }) else { return }
            tasks[taskIndex].completed.toggle()
            
            do {
                try container.viewContext.save()
            } catch {
                print("Error toggling task completion: \(error)")
            }
        }

    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("We have permission to send notifications.")
            } else {
                print("Permission to send notifications was denied.")
            }
        }
    }
    
    func scheduleNotification(for task: ToDo) {
        let content = UNMutableNotificationContent()
        content.title = "Task Reminder"
        content.body = "Don't forget to complete \(task.name ?? "Dont forget to complete tasks")."

        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: task.deadline!)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            } else {
                print("Notification send")
            }
        }
    }

}

