//
//  settings.swift
//  idea 4
//
//  Created by Navneet Dagdiya on 14/3/2026.
//

import SwiftUI
struct settings: View {
    
    @State private var isOn: Bool = false
    
    var body: some View {
        VStack {
            Text("General")
                .font(.largeTitle)
            Toggle("Placeholder", isOn: $isOn)
                .toggleStyle(.switch)
                .padding()

            Text("currently their are no settings, please stand by for updates!")
                .padding()
            
            Text("made with ❤️ by [nav.](https://adeveloperduck.github.io/index.html)")
                .padding()
                .font(.callout)
        }
    }
}

#Preview {
    settings()
}
