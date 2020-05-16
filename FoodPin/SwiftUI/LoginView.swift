//
//  LoginView.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/14/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct LoginView : View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack {
            WelcomeText()
            UserImage()
            TextField("Username", text: $username)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            Button(action: {print("Button tapped")}) {
               LoginButtonContent()
            }
            .padding(.bottom, 20)
            Button(action: {print("Button tapped")}) {
                
               SignUpButtonContent()
            }
        }
        .padding()
    }
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif

struct WelcomeText : View {
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
        
            .fontWeight(.semibold)
            .padding(.bottom, 20)
            .foregroundColor(.black)
    }
}

struct UserImage : View {
    var body: some View {
        return Image("iconfr")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 150, height: 150)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 75)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.red)
            .cornerRadius(15.0)
    }
}
    struct SignUpButtonContent : View {
    var body: some View {
        return Text("Sign Up")
            .font(.headline)
            .foregroundColor(.red)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color.white)
            .cornerRadius(15.0)
    }
    }

