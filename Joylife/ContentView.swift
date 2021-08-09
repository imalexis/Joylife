//
//  ContentView.swift
//  Joylife
//
//  Created by alexis on 8/4/21.
//

import SwiftUI


// Response -> State
class ContentViewState: ObservableObject {
    @Published var isLogin: Bool


    init(isLogin: Bool) {
        self.isLogin = isLogin
    }
}

struct ContentView: View {
    @StateObject var contentViewState: ContentViewState = ContentViewState(isLogin: false)

    var body: some View {
        if contentViewState.isLogin {
            MainView()
        } else {
//            WelcomePage(isLogin: $contentViewState.isLogin)
            WelcomePage().environmentObject(contentViewState)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
