//
//  ObservableObject.swift
//  railrest
//
//  Created by Reyhan Ariq Syahalam on 01/04/24.
//

import Foundation

class Logger: ObservableObject {
    @Published var messages: [String] = []

    func log(_ message: String) {
        DispatchQueue.main.async {
            self.messages.append(message)
        }
    }
}

