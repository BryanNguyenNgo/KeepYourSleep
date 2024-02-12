//import SwiftUI
//
//class ViewModel: ObservableObject {
//    @Published var completionText: String = ""
//    @Published var imageURL: String = ""
//    @Published var isLoading: Bool = false // Add an isLoading flag
//    
//    let apiKey = "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"
//    
//    func chatCompletion(prompt: String, question: String, completion: @escaping (String) -> Void) {
//        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/chat/completions")!)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        let messages: [[String: Any]] = [
//            ["role": "system", "content": prompt],
//            ["role": "user", "content": question]
//        ]
//        
//        let parameters: [String: Any] = [
//            "model": "gpt-3.5-turbo-0613",//use model: gpt-4-0613 or gpt-3.5-turbo-0613
//            "messages": messages,
//            "max_tokens": 100,
//            "temperature": 0.9
//        ]
//        
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            request.httpBody = jsonData
//        } catch {
//            print("Error creating JSON data: \(error)")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let messages = responseDict?["choices"] as? [[String: Any]] {
//                        if let message = messages.first {
//                            if let content = message["message"] as? [String: Any] {
//                                if let text = content["content"] as? String {
//                                    completion(text) // Pass the result using the completion handler
//                                }
//                            }
//                        }
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                    self.isLoading = false
//                }
//            }
//        }
//        
//        task.resume()
//    }
//    
//    func imageCompletion(prompt: String, completion: @escaping (String) -> Void) {
//        var request = URLRequest(url: URL(string: "https://api.openai.com/v1/images/generations")!)
//        request.httpMethod = "POST"
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        //The size of the generated images. Must be one of 256x256, 512x512, or 1024x1024
//        let parameters: [String: Any] = [
//            "prompt": prompt,
//            "n": 1,
//            "size": "512x512"
//        ]
//        
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            request.httpBody = jsonData
//        } catch {
//            print("Error creating JSON data: \(error)")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//            
//            if let data = data {
//                do {
//                    let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let data = responseDict?["data"] as? [[String: Any]],
//                       let url = data[0]["url"] as? String {
//                        completion(url) // Pass the image URL using the completion handler
//                    }
//                } catch {
//                    print("Error parsing JSON: \(error.localizedDescription)")
//                    self.isLoading = false
//                }
//            }
//        }
//        
//        task.resume()
//    }
//    
//    func fetchTipsImageCompletion() {
//        isLoading = true // Set isLoading to true when fetching starts
//        
//        let prompt1 = "You are a helpful assistant."
//        let question1 = "Generate a creative tip for better sleep for me as a teenagers"
//        
//        chatCompletion(prompt: prompt1, question: question1) { tips in
//            let prompt2 = "You are a helpful assistant."
//            let question2 = "Create a prompt to generate an English image for this text <<<\(tips)>>>"
//          //  let question2 = "Create a prompt to generate an cute and creative animation image for this text <<<\(tips)>>>"
//            
//            self.chatCompletion(prompt: prompt2, question: question2) { promptImage in
//                self.imageCompletion(prompt: promptImage) { imageURL in
//                    DispatchQueue.main.async {
//                        self.completionText = tips
//                        self.imageURL = imageURL
//                        self.isLoading = false
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct TipsImageView: View {
//    @AppStorage ("background") private var savedbackground = "defaultbackground"
//    @StateObject private var viewModel = ViewModel()
//    
//    var body: some View {
//        ZStack{
//            Image(savedbackground)
//            VStack {
//                //                Image("tip")
//                //                    .resizable()
//                //                    .frame(width: 450, height:200, alignment: .center)
//                AsyncImage(url: URL(string: viewModel.imageURL)) { image in
//                    image
//                        .resizable()
//                        .frame(width: 300, height: 300, alignment: .center)
//                } placeholder: {
//                    // Placeholder image or activity indicator while loading
//                    if viewModel.isLoading { // Display loading status
//                        ProgressView()
//                    }
//                }
//                
//                Text("Tips to sleep better")
//                    .font(.title)
//                    .padding()
//                    .cornerRadius(90)
//                    .font(.system(size: 25))
//                
//                if viewModel.isLoading { // Display loading status
//                    ProgressView("Hang on...")
//                        .padding()
//                } else {
//                    Text(viewModel.completionText)
//                        .padding()
//                }
//                
//                Button("Generate tip for me to sleep well") {
//                    viewModel.fetchTipsImageCompletion()
//                }
//                .padding()
//                .cornerRadius(90)
//                .font(.system(size: 20))
//            }
//            // Trigger fetchTipsImageCompletion when the view first appears
//            .onAppear {
//                viewModel.fetchTipsImageCompletion()
//            }
//        }
//    }
//}
//
