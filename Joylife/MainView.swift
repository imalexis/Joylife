//
//  MainView.swift
//  Joylife
//
//  Created by alexis on 8/4/21.
//

import SwiftUI

struct MainView: View {    
    var body: some View {

        TabView {
            HomePage()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
            StorePage()
                    .tabItem {
                        Label("Store", systemImage: "bag")
                    }
            PostPage()
                    .tabItem {
                        Label("11", systemImage: "plus.rectangle.fill")
                    }
            MessagePage()
                    .tabItem {
                        Label("Message", systemImage: "ellipsis.bubble")
                    }

            MePage()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Me")
                    }
        }
                .accentColor(.black)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



