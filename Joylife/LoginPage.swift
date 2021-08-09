//
//  LoginPage.swift
//  Joylife
//
//  Created by alexis on 8/4/21.
//

import SwiftUI

class LoginState: ObservableObject {
    @Published var emailInput: String
    @Published var passwordInput: String

    init(emailInput: String, passwordInput: String) {
        self.emailInput = emailInput
        self.passwordInput = passwordInput
    }
}

struct LoginPage: View {
    let screenSize: CGRect = UIScreen.main.bounds

    @StateObject var loginState = LoginState(emailInput: "", passwordInput: "")
//    @State var emailInput: String = ""
//    @State var passwordInput: String = ""
//
    @Binding var isLogin: Bool

    func loadData(url: String, loginRequest: LoginRequest) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
        } catch {
            print("JSON Encoder encode failed")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.isLogin = decodedResponse.isLogin
                    }
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()

        // Mock
        self.isLogin = true
    }

    var body: some View {

        ZStack {
            Color.black.opacity(0.06).edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: screenSize.height * 0.02) {
                Text("Login for better service")
                        .font(.system(size: 45, weight: .medium, design: .default))
                        .foregroundColor(Color.black.opacity(0.65))
                        .padding(.bottom, screenSize.height * 0.15)
                TextField("Email", text: $loginState.emailInput)
                        .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                        .background(Color.white)
                        .cornerRadius(10)


                TextField("Password", text: $loginState.passwordInput)
                        .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                        .background(Color.white)
                        .cornerRadius(10)


                Button(
                        action: {

                            let request = LoginRequest(email: self.loginState.emailInput, password: self.loginState.passwordInput)

                            loadData(url: "http://192.168.0.103:8080/apis/v1/login", loginRequest: request)
                        },
                        label: {
                            Text("Login")
                                    .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                                    .background(Color.red)
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                        })
                        .padding(.top, screenSize.height * 0.1)
                        .padding(.bottom, screenSize.height * 0.05)


            }
        }
    }
}


struct LoginPage_Preview: PreviewProvider {
    @State static var contentViewState: ContentViewState = ContentViewState(isLogin: false)
    static var previews: some View {
        LoginPage(isLogin: $contentViewState.isLogin)
    }
}
