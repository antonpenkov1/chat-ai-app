//
//  ViewModel.swift
//  ChatAI 3.0
//
//  Created by Антон Пеньков on 09.04.2023.
//

import SwiftUI
import CoreData
import OpenAISwift

final class ViewModel: ObservableObject {
    init() {}
    
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: "Paste API Key here...")
    }
    
    func send(messageText: String, completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: messageText,
                               maxTokens: 500,
                               completionHandler: { result in
            switch result {
            case .success(let model):
                let output = model.choices?.first?.text ?? ""
                completion(output)
            case .failure:
                break
            }
        })
    }
}
