//
//  SignupPage.swift
//  Joylife
//
//  Created by alexis on 9/4/21.
//

import SwiftUI
import Logging

let logger = Logger(label: "Joylife")

class SignupState: ObservableObject {
    @Published var emailInput: String
    @Published var passwordInput: String
    @Published var isSignup: Bool

    init(emailInput: String, password: String, isSignup: Bool) {
        self.emailInput = emailInput
        self.passwordInput = password
        self.isSignup = isSignup
    }
}

struct SignupPage: View {
    let screenSize: CGRect = UIScreen.main.bounds

    @StateObject var signupState = SignupState(emailInput: "", password: "", isSignup: false)
    @EnvironmentObject var contentViewState: ContentViewState
//    @State var emailInput: String = ""
//    @State var passwordInput: String = ""
//
//    @State var isSignup: Bool = false
    //  @Binding var isLogin: Bool

    func loadData(url: String, signupRequest: SignupRequest) {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(signupRequest)
        } catch {
            print("JSON Encoder encode failed")
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            logger.info("load data")
            //
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response: \(dataString) \n")
            }

            if let data = data {
                print(data)
                if let decodedResponse = try? JSONDecoder().decode(SignupResponse.self, from: data) {
                    print("dispatch queue")
                    DispatchQueue.main.async {
                        self.signupState.isSignup = decodedResponse.errorCode == 0
                        print(self.signupState.isSignup)
                    }
                    return
                }
            }
            print("end let data = data")

        }.resume()

    }

    var body: some View {

        TextField("Email", text: $signupState.emailInput)
                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                .background(Color.white)
                .cornerRadius(10)


        TextField("Password", text: $signupState.passwordInput)
                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                .background(Color.white)
                .cornerRadius(10)

        Button(
                action: {
                    let request = SignupRequest(email: signupState.emailInput, password: signupState.passwordInput)

                    loadData(url: "http://192.168.0.193:8080/apis/v1/signup", signupRequest: request)
                },
                label: {
                    Text("Signup")
                            .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.06)
                            .background(Color.red.opacity(0.65))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                })

                .background(
                        NavigationLink(
                                destination: LoginPage(isLogin: $contentViewState.isLogin),
                                isActive: $signupState.isSignup
                        ) {
                        }

                )
                .padding(.top, screenSize.height * 0.1)
                .padding(.bottom, screenSize.height * 0.05)
    }
}

struct SignupPage_Previews: PreviewProvider {
    @State static var isSignup = false
    @State static var isLogin = false
    static var previews: some View {
        SignupPage()
    }
}
