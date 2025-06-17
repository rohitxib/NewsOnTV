//
//  Login.swift
//  SctAppTV
//
//  Created by Rohit.Dwivedi on 02/06/25.
//
import SwiftUI

struct LoginView: View {
    enum Field: Hashable {
        case email, password, login
    }
    
    @State private var email = ""
    @State private var password = ""
    @FocusState private var focusedField: Field?
    @State private var navigate = false
    
    var body: some View {
        NavigationStack {
        VStack(spacing: 40) {
            Text("Welcome to TV App")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.white)
            
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(10)
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                
                SecureField("Password", text: $password)
                    .textContentType(.password)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(10)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        login()
                    }
            }
            .frame(width: 600)
            
            Button(action: login) {
                Text("Login")
                    .frame(width: 600, height: 60)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(.plain)
            .focused($focusedField, equals: .login)
        }
        .padding(.top, 100)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .onAppear {
            focusedField = .email
        }
        .navigationDestination(isPresented: $navigate) {
            ContentView()
        }
    }
}

    private func login() {
        
                if true {
                    navigate = true
                }
    }

   
    }



//
//struct LoginView: View {
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showingAlert = false
//    @State private var alertMessage = ""
//    @State private var navigate = false
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Text("Login")
//                    .font(.largeTitle)
//                    .bold()
//
//                TextField("Email", text: $email)
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color(.gray))
//                    .cornerRadius(8)
//                    .frame(width: 800)
//                    .padding(.bottom,50)
//
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color(.gray))
//                    .cornerRadius(8)
//                    .frame(width: 800)
//                Button(action: {
//                    login()
//                }) {
//                    Text("Login")
//                        .foregroundColor(.white)
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .cornerRadius(8)
//                        .frame(width: 800)
//
//                }
//
//                Spacer()
//            }
//            .padding()
//            .alert(isPresented: $showingAlert) {
//                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//            }
//            .navigationDestination(isPresented: $navigate) {
//                ContentView()
//            }
//        }
//        
//    }
//
//    func login() {
////        guard !email.isEmpty, !password.isEmpty else {
////            alertMessage = "Please enter both email and password."
////            showingAlert = true
////            return
////        }
//
//        // Dummy authentication logic
//        if true {
//            navigate = true
//        }
//    }
//}

