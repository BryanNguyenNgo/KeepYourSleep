import SwiftUI

class ViewModel: ObservableObject {
    @Published var completionText: String = ""
    @Published var isLoading: Bool = false // Add an isLoading flag
    
    func fetchChatCompletion() {
        isLoading = true // Set isLoading to true when fetching starts
        
        
        let apiKey = "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"
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let messages: [[String: Any]] = [
            ["role": "system", "content": "You are an helpful AI assistant."],
            ["role": "user", "content": "Generate a creative tip for better sleep"]
        ]
        
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo-0613",
            "messages": messages,
            "max_tokens": 100,
            "temperature": 0.9
        ]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    //print("Response Dictionary: \(responseDict)")
                    if let messages = responseDict?["choices"] as? [[String: Any]] {
                        //print("Messages: \(messages)")
                        
                        if let message = messages.first {
                            //print("Message: \(message)")
                            
                            if let content = message["message"] as? [String: Any] {
                                print("Content: \(content)")
                                
                                if let text = content["content"] as? String {
                                    print("Text: \(text)")
                                    
                                    DispatchQueue.main.async {
                                        self.completionText = text
                                        self.isLoading = false
                                    }
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                    self.isLoading = false
                }
            }
        }
        
        task.resume()
    }
}
struct TipsView: View {
    @AppStorage ("background") private var savedbackground = "defaultbackground"
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        ZStack{
//            Image(savedbackground)
            VStack {
                Image("tip2")
                    .resizable()
                    .frame(width: 450, height:200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Text("Tips to sleep better")
                    .font(.title)
                    .padding()
                    .cornerRadius(90)
                    .font(.system(size: 30))
                .foregroundColor(.white)
                
                if viewModel.isLoading { // Display loading status
                    ProgressView("Hang on...")
                        .padding()
                } else {
                    Text(viewModel.completionText)
                        .padding()
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                }
                
                Button("Tip for me to sleep well") {
                    viewModel.fetchChatCompletion()
                }
                .padding()
                .background(Color.purple)
                .foregroundColor(.white)
                .cornerRadius(10)
                .font(.system(size: 20))
            }
        }
    }
}
