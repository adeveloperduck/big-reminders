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
    let title: String
    var isComplete: Bool = false
}


var Reminders: [reminder] = [ ]

struct currentReminders: View {
    @State private var showField = false
    @State private var inputText = ""
    @State private var savedText = ""
    @State private var reminders = Reminders
    
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
                List($reminders) { $reminder in
                    HStack {
                        if reminder.isComplete {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(Color.accentColor)
                                .transition(.scale.combined(with: .opacity))
                                .onTapGesture {
                                    reminder.isComplete.toggle()
                                }
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(Color.accentColor)
                                .transition(.scale.combined(with: .opacity))
                                .onTapGesture {
                                    reminder.isComplete.toggle()
                                    let id = reminder.id
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                        withAnimation {
                                            reminders.removeAll { $0.id == id }
                                        }
                                    }
                                
                                }
                        }
                            
                        
                        if reminder.isComplete {
                            Text(reminder.title)
                                .foregroundStyle(Color.gray)
                                .transition(.opacity)
                        } else {
                            Text(reminder.title)
                                .transition(.opacity)
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
                Button("Save") {
                    reminders.append(reminder(title: inputText))
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
