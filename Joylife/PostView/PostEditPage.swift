//
//  PostEditPage.swift
//  Joylife
//
//  Created by alexis on 21/4/21.
//

import SwiftUI

struct PostEditPage: View {
    let screenSize: CGRect = UIScreen.main.bounds
    @Binding var selectedImage: UIImage?
    @State private var titleInput: String = ""
    @State private var textInput: String = ""
    @State private var isAlertDisplay = false
    @Binding var isActive: Bool
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                HStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: screenSize.width * 0.25, height: screenSize.width * 0.25)
                            .aspectRatio(contentMode: .fit)
                            
                            // .padding(screenSize.width * 0.1)
                           // .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5), lineWidth: 0.8))
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenSize.width * 0.05, height: screenSize.width * 0.05)
                            .foregroundColor(Color(.systemGray3))
                            .padding(screenSize.width * 0.1)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray5), lineWidth: 0.8))
                    }
                }
                .padding()
                
                TextField ("An interesting title", text: $titleInput)
                Divider()
                ScrollView(.vertical, showsIndicators: true, content: {
                    ZStack {
                        TextEditor(text: $textInput)
                                .frame(height: screenSize.width * 0.2)
                        if textInput.isEmpty {
                            HStack {
                               Text("Add text")
                                .opacity(0.22)
                               Spacer()
                            }
                            
                        }
                       
                        
                    }
                    
                    
                })
                .frame(height: screenSize.height*0.15)
                Divider()
                
                
                Button(action: {
                    
                }, label: {
                    Text("Post")
                        .font(.system(size: 30, weight: .regular, design: .default))
                        .frame(width: screenSize.width*0.7, height: screenSize.height*0.018)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 28))
                })
            
        }
            .navigationBarItems(
                leading:
                    Button(
                        action:{
                            isAlertDisplay.toggle()
                        },
                        label: {
                            Image(systemName: "multiply")
                                .foregroundColor(Color.black.opacity(0.3))
                                .font(.system(size: 23))
                        }
                    )
                                    .alert(isPresented: $isAlertDisplay, content: {
                                        let firstButton = Alert.Button.destructive(Text("DISCARD & EXIT"), action: {self.isActive.toggle()})
                                        let secondButton = Alert.Button.cancel()
                                        return Alert(title: Text("Discard Post?"), message: Text("Do you wan to discard your post?"), primaryButton: firstButton, secondaryButton: secondButton)
                                        
                                    }),
                trailing:
                    Button(
                        action: {},
                        label: {
                            Text("Post")
                        }
                    )
            )
            .padding(.horizontal, screenSize.width * 0.05)
        
            
    }
       
}
}
    
struct PostEditPage_Previews: PreviewProvider {
    @State static private var selectedImage: UIImage? = UIImage(contentsOfFile: "avatar")
    @State static private var isActive: Bool = false
    static var previews: some View {
        PostEditPage(selectedImage: $selectedImage, isActive: $isActive)
    }
}
