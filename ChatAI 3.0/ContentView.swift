//
//  ContentView.swift
//  ChatAI 3.0
//
//  Created by Антон Пеньков on 09.04.2023.
//

import SwiftUI
import CoreData
import OpenAISwift

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to ChatAI"]
    
    var body: some View {
        VStack {
            HStack{
                Text("ChatAI")
                    .font(.system(size: 30, weight: .bold, design: .serif))
                    .bold()
                
                Image(systemName: "message.circle")
                    .font(.system(size: 40))
                    .foregroundColor(.purple.opacity(0.8))
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.contains("[You]") {
                        let newMessage = message.replacingOccurrences(of: "[You]", with: "")
                        
                        HStack{
                            Spacer()
                            
                            ZStack{
                                Text(newMessage)
                                    .padding()
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(.white)
                                    .background(.purple.opacity(0.8))
                                    .background(.white)
                                    .cornerRadius(25)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                            
                        }
                    } else {
                        HStack{
                            ZStack {
                                Text(message)
                                    .padding()
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(.black)
                                    .background(.white)
                                    .cornerRadius(25)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 10)
                            }
                            
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }.rotationEffect(.degrees(180))
                .background(Image("mountainBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .clipped()
                )
            
            HStack {
                TextField("Type here", text: $messageText, axis: .vertical)
                    .lineLimit(10)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(25)
                    .onSubmit {
                        send()
                    }
                
                Button {
                    send()
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .padding()
                .frame(width: 80, height: 50)
                .font(.system(size: 26))
                .foregroundColor(.white)
                .background(.purple.opacity(0.8))
                .cornerRadius(25)
            }
            .padding()
        }
        .onAppear {
            viewModel.setup()
        }
    }
    
    
    func send() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        messages.append("[You]" + messageText)
        viewModel.send(messageText: messageText) { response in
            DispatchQueue.main.async {
                self.messages.append(response)
                self.messageText = ""
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
