//
//  ContentView.swift
//  ProjectTelekinesis
//
//  Created by Dakota Kim on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var prompt: String = ""
    @State private var output = ""

    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                Text(output)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.bottom)
            }

            HStack {
                TextField("Enter command...", text: $prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Send Prompt") {
                    sendPrompt(prompt) { result in
                        DispatchQueue.main.async {
                            self.output = result
                        }
                    }
                }
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
