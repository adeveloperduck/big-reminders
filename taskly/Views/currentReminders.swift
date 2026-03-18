//
//  currentReminders.swift
//  idea 4
//
//  Created by Navneet Dagdiya on 14/3/2026.
//

import SwiftUI
import Foundation

struct reminder: Identifiable {
    let id = UUID()
    var title: String
    var isComplete: Bool = false
}


var Reminders: [reminder] = [ ]

struct currentReminders: View {
    @State private var showField = false
    @State private var inputText = ""
    @State private var savedText = ""
    @State private var reminders = Reminders
    @State private var editingReminder: reminder? = nil
    
    var body: some View {
        Group {
            if reminders.isEmpty {
                VStack {
                    Text("No tasks, try creating some")
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(.gray)
                    Image(systemName: "lightbulb")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundStyle(.gray)
                        .padding()
                }
            } else {
                List(reminders) { reminder in
                    HStack {
                        if reminder.isComplete {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Color.accentColor)
                                .transition(.scale.combined(with: .opacity))
                                .onTapGesture {
                                    if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                        reminders[index].isComplete.toggle()
                                    }
                                }
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(Color.accentColor)
                                .transition(.scale.combined(with: .opacity))
                                .onTapGesture {
                                    if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
                                        reminders[index].isComplete.toggle()
                                    }
                                    let id = reminder.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(settingsVariables.timeUntilTaskDeleted)) {
                                        withAnimation {
                                            reminders.removeAll { $0.id == id }
                                        }
                                    }
                                
                                }
                        }
                            
                        
                        Text(reminder.title)
                            .foregroundStyle(reminder.isComplete ? .gray : .primary)
                            .onTapGesture {
                                inputText = reminder.title
                                editingReminder = reminder
                                showField = true
                            }
                    }
                    .listRowSeparator(.hidden)
                }
                
                
            }
        }
        .navigationTitle("Tasks")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button("New Task") {
                    showField.toggle()
                }
            }
        }
        
        if showField {
            HStack {
                TextField("Task name", text: $inputText)
                    .textFieldStyle(.roundedBorder)
                Button(editingReminder == nil ? "Save" : "Update") {
                    if let editing = editingReminder {
                        // 🔥 EDIT MODE
                        if let index = reminders.firstIndex(where: { $0.id == editing.id }) {
                            reminders[index].title = inputText
                        }
                        editingReminder = nil
                    } else {
                        // 🔥 CREATE MODE
                        reminders.append(reminder(title: inputText))
                    }

                    inputText = ""
                    showField = false
                }
            }
            .padding()
        }
    }
}
    #Preview {
        currentReminders()
    }

