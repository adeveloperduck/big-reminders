//
//  currentReminders.swift
//  idea 4
//
//  Created by Navneet Dagdiya on 14/3/2026.
//

import SwiftUI

struct currentReminders: View {
    @State private var showReminder = false

    var body: some View {
        VStack {
            Text("Reminders")
            if showReminder {
                newReminder()
            } else {
                Button("New Reminder") {
                    showReminder = true
                }
                .padding()
            }
            
            Text("sample text")
        }
        
    }
}

#Preview {
    currentReminders()
}
