//
//  ContentView.swift
//  ProjectTelekinesis
//
//  Created by Dakota Kim on 4/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var prompt: String = ""
    @State private var chatLog: [String] = []
    @State private var isProcessing: Bool = false
    @State private var screenshot: UIImage? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(chatLog.indices, id: \.self) { index in
                        Text(chatLog[index])
                            .padding(10)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(12)
            .frame(maxHeight: 250)
            
            // Screenshot Viewer
            Group {
                if let screenshot = screenshot {
                    Image(uiImage: screenshot)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                        .frame(maxHeight: 200)
                } else {
                    Text("TODO: No screen preview yet")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                }
            }
            
            HStack {
                TextField("Enter a prompt...", text: $prompt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isProcessing)
                
                Button(action: sendPrompt) {
                    if isProcessing {
                        ProgressView()
                    } else {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                    }
                }
                .disabled(prompt.isEmpty || isProcessing)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    func sendPrompt() {
        let userMessage = "🧠 You: \(prompt)"
        chatLog.append(userMessage)
        isProcessing = true
        
        // Simulate AI response and screen capture
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            chatLog.append("🤖 Claude: Working on your request...")
            loadMockScreenshot()
            isProcessing = false
            prompt = ""
        }
    }
    
    // MARK: - Mock Screenshot Loader
    func loadMockScreenshot() {
        // Replace with real networking / image streaming
        screenshot = UIImage(systemName: "macwindow")
    }
}

#Preview {
    ContentView()
}
