//
//  SSHExecutor.swift
//  ProjectTelekinesis
//
//  Created by Dakota Kim on 4/7/25.
//

import Foundation


import Foundation

struct PromptRequest: Codable {
    let prompt: String
}

struct PromptResponse: Codable {
    let prompt: String?
    let stdout: String?
    let stderr: String?
    let error: String?
}

func sendPrompt(_ prompt: String, completion: @escaping (String) -> Void) {
    guard let url = URL(string: "http://192.168.1.232:8000/run") else {
        completion("❌ Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.timeoutInterval = 60 // Increase timeout to 60 seconds

    let promptData = PromptRequest(prompt: prompt)
    guard let httpBody = try? JSONEncoder().encode(promptData) else {
        completion("❌ Failed to encode prompt")
        return
    }

    request.httpBody = httpBody

    // Create a URLSession with increased timeouts
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 60
    let session = URLSession(configuration: configuration)

    session.dataTask(with: request) { data, response, error in
        if let error = error {
            completion("❌ Network error: \(error.localizedDescription)")
            return
        }

        guard let data = data else {
            completion("❌ No data received")
            return
        }

        do {
            let decoded = try JSONDecoder().decode(PromptResponse.self, from: data)
            if let err = decoded.error {
                completion("❌ Server error: \(err)")
            } else {
                let output = """
                🧠 Prompt: \(decoded.prompt ?? "n/a")

                ✅ Output:
                \(decoded.stdout ?? "")

                ⚠️ Errors:
                \(decoded.stderr ?? "")
                """
                completion(output)
            }
        } catch {
            completion("❌ Failed to decode response: \(error.localizedDescription)")
        }
    }.resume()
}
