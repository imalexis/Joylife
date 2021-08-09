//
//  HomePage.swift
//  Joylife
//
//  Created by alexis on 14/4/21.
//

import SwiftUI

struct HomePage: View {
    let screenSize: CGRect = UIScreen.main.bounds
    @State var userPosts = [UserPosts]()

    func loadData() {

        let images = ["https://image.tmdb.org/t/p/original//pThyQovXQrw2m0s9x82twj48Jq4.jpg",
                      "https://image.tmdb.org/t/p/original//vqzNJRH4YyquRiWxCCOH0aXggHI.jpg",
                      "https://image.tmdb.org/t/p/original//6ApDtO7xaWAfPqfi2IARXIzj8QS.jpg",
                      "https://image.tmdb.org/t/p/original//7GsM4mtM0worCtIVeiQt28HieeN.jpg",
                      "https://media.wired.com/photos/5b899992404e112d2df1e94e/master/pass/trash2-01.jpg",
                      "https://zvelo.com/wp-content/uploads/2018/11/anatomy-of-a-full-path-url-hostname-tld-path-protocol.jpg"
        ]
        for img in images {
            userPosts.append(UserPosts(image: img))
        }

    }

    private var gridItemLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 2)


    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridItemLayout, spacing: screenSize.width * 0.08) {
                    ForEach(userPosts, id: \.self) { userPost in
                        NavigationLink(destination: PostDetail()) {

                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: userPost.image)!, placeholder: { Text("Loading ...") }, image: { Image(uiImage: $0).resizable() }
                                )
                                        .aspectRatio(contentMode: .fit)

                                HStack {
                                    Text(userPost.title!)
                                            .font(.system(size: 14, weight: .regular, design: .default))
                                            .foregroundColor(.black)
                                }

                                HStack(spacing: 2) {
                                    Image(userPost.userAvatar!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenSize.width * 0.1)
                                            .clipShape(Circle())
                                    Text(userPost.username!)
                                            .font(.system(size: 12, weight: .thin, design: .default))
                                            .foregroundColor(.black)
                                    Spacer()
                                    Image(systemName: "suit.heart")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15))
                                    Text("\(userPost.likes!)")
                                            .font(.system(size: 13, weight: .light, design: .default))
                                            .foregroundColor(Color(.black))
                                }
                                        .padding(.bottom, 8)

                            }
                                    .cornerRadius(6)
                            //.padding(.vertical, screenSize.height*0.015)
                        }

                    }
                }

            }
                    .padding(.horizontal, screenSize.width * 0.014)
                    .toolbar(content: {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            HStack {
                                Spacer()
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Follow")
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black)
                                })
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Text("Explore")
                                            .font(.system(size: 16, weight: .regular, design: .default))
                                            .foregroundColor(.black)
                                })
                                Spacer(minLength: screenSize.width * 0.2)
                                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                    Image(systemName: "magnifyingglass")
                                            .foregroundColor(.black)
                                })
                            }
                        }
                    })
        }
                .background(Color.black.opacity(0.2))
                .onAppear(perform: { loadData() })
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
