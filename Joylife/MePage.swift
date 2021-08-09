//
//  MePage.swift
//  Joylife
//
//  Created by alexis on 14/4/21.
//

import SwiftUI

struct MePage: View {
    let screenSize: CGRect = UIScreen.main.bounds

    var body: some View {
        NavigationView {
            //Color.blue.ignoresSafeArea()
            List{
                Text("q")
                Text("q")
            }
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Image("avatar")
                            .resizable()
                            .frame(width: screenSize.width*0.2, height: screenSize.width*0.2)
                            .clipShape(Circle())
                            .scaledToFit()
                        VStack {
                            Text("username")
                            Text("userid: 28976689")
                        }
                    }
                    HStack {
                        VStack {
                            Text("331")
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                            Text("Following")
                        }
                        VStack {
                            Text("135")
                            Text("Followers")
                        }
                        VStack {
                            Text("135")
                            Text("Likes & Favs")
                        }
                        Button(
                            action: {},
                            label: {
                            Text("Profile Info")
                        })
                        Button(
                            action: {},
                            label: {
                            Image(systemName: "gearshape")
                        })
                    }
                }
    //            .background(
    //                    LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
    //                )
                .navigationBarItems(
                    trailing: Button(action: {}, label: {
                        Image(systemName: "square.and.arrow.up")
                    })
            )
            }
            

        }

        
    }
}

struct MePage_Previews: PreviewProvider {
    static var previews: some View {
        MePage()
    }
}
