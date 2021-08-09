//
//  WelcomePage.swift
//  Joylife
//
//  Created by alexis on 9/4/21.
//

import SwiftUI


struct WelcomePage: View {
    let screenSize: CGRect = UIScreen.main.bounds
    @State var isShowLoginPage: Bool = false
    // @Binding var isLogin: Bool
    @EnvironmentObject var contentViewState: ContentViewState
    var body: some View {
        NavigationView {
            ZStack {
                Image("lakemcdonald")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)

                VStack {
                    VStack {
                        Text("Joylife")
                                .foregroundColor(.white)
                                .font(.system(size: 70, weight: .heavy, design: .serif))
                        Text("Tag My life")
                                .foregroundColor(.white)
                                .font(.system(size: 30, weight: .light, design: .serif))
                    }
                            .padding(.bottom, screenSize.height * 0.2)

                    NavigationLink(destination: LoginPage(isLogin: $contentViewState.isLogin)) {
                        Text("LOG IN")
                                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.07)
                                .background(Color.white)
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding()
                                .padding(.top, screenSize.height * 0.1)
                    }
                    NavigationLink(destination: SignupPage().environmentObject(contentViewState)) {
                        Text("SIGN UP")
                                .frame(width: screenSize.width * 0.75, height: screenSize.height * 0.07)
                                .background(Color.gray.opacity(0.5))
                                .cornerRadius(10)
                                .font(.system(size: 20, weight: .medium, design: .default))
                                .foregroundColor(.black)
                                .padding(.bottom, screenSize.height * 0.1)
                    }

                    HStack {
                        Button(
                                action: {

                                },
                                label: {
                                    Image(systemName: "applelogo")
                                            .renderingMode(.original)
                                            .font(.largeTitle)
                                            .padding(8)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                })
                    }
                }
            }
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    @EnvironmentObject static var contentViewState: ContentViewState
    static var previews: some View {
        WelcomePage().environmentObject(contentViewState)
    }
}
