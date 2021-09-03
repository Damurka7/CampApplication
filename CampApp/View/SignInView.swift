//
//  SignInView.swift
//  LoginUI
//
//  Created by Damir Nurtdinov on 05.08.2021.
//  Copyright © 2021 Ian Solomein. All rights reserved.
//

/*
 This file also contains a SignUpView structure
 */
 

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import UIKit


let db = Firestore.firestore()

struct SignInView : View {
    
    @State var username = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @State var show = false
    
    //var ref: DatabaseReference!

    var ref = Database.database().reference()
    
    var body : some View{
        VStack {
            VStack{
                Text("Sign In").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
                
                VStack(alignment: .leading){
                    
                    VStack(alignment: .leading){
                        
                        Text("Username").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        HStack{
                            
                            TextField("Enter Your Username", text: $username)
                            
                        }
                        
                        Divider()
                        
                    }.padding(.bottom, 15)
                    
                    VStack(alignment: .leading){
                        
                        Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        
                        SecureField("Enter Your Password", text: $pass)
                        
                        Divider()
                    }
                    
                }.padding(.horizontal, 6)
                
                Button(action: { //the "sign in" button
                    
                    signInWithEmail(email: self.username, password: self.pass) { (verified, status) in
                        
                        if !verified {
                            
                            self.message = status
                            self.alert.toggle()
                        }
                        else{
                            
                            
                            UserDefaults.standard.set(true, forKey: "status")
                            NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            
                        }
                    }
                    
                }) {
                    
                    Text("Sign In").foregroundColor(.black).frame(width: UIScreen.main.bounds.width - 120).padding()
                    
                    
                }
                .background(Color(#colorLiteral(red: 0.8759207159, green: 0.8759207159, blue: 0.8759207159, alpha: 1)))
                .clipShape(Capsule())
                .padding(.top, 45)
                
            }.padding()
                .alert(isPresented: $alert) {
                    
                    Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            }
            VStack{
                
                Text("(or)").foregroundColor(Color.gray.opacity(0.5)).padding(.top,30)
                
                
                HStack(spacing: 8){
                    
                    Text("Don't Have An Account ?").foregroundColor(Color.gray.opacity(0.5))
                    
                    Button(action: { //the "sign up"
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Text("Sign Up")
                        
                    }.foregroundColor(.blue)
                    
                }.padding(.top, 25)
                
            }.sheet(isPresented: $show) {
                
                SignUpView(show: self.$show)
            }
        }
    }
}

struct SignUpView : View {
    
    @State var username = ""
    @State var pass = ""
    @State var message = ""
    @State var alert = false
    @Binding var show : Bool
    
    var body : some View{
        
        VStack{
            Text("Sign Up").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                VStack(alignment: .leading){
                    
                    Text("Username").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    HStack{
                        
                        TextField("Enter Your Username", text: $username)
                        
                        if username != ""{
                            
                            Image("check").foregroundColor(Color.init(.label))
                        }
                        
                    }
                    
                    Divider()
                    
                }.padding(.bottom, 15)
                
                VStack(alignment: .leading){
                    
                    Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                    
                    SecureField("Enter Your Password", text: $pass)
                    
                    Divider()
                }
                
            }.padding(.horizontal, 6)
            
            Button(action: {
                
                signUpWithEmail(email: self.username, password: self.pass) { (verified, status) in
                    
                    if !verified{
                        
                        self.message = status
                        self.alert.toggle()
                        
                    }
                    else{
                        
                        UserDefaults.standard.set(true, forKey: "status")
                        
                        self.show.toggle()
                        
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
                
            }) {
                
                Text("Sign Up").foregroundColor(.black).frame(width: UIScreen.main.bounds.width - 120).padding()
                
                
            }.background(Color("color"))
                .clipShape(Capsule())
                .padding(.top, 45)
            
        }.padding()
            .alert(isPresented: $alert) {
                
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
        }
    }
}




func signUpWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
        
        if err != nil{
            
            completion(false,(err?.localizedDescription)!)
            return
        }


        print(email)
        print(res!.user.uid)
        
        user.email = (res?.user.email)!
        user.password = password
        
        db.collection("users").addDocument(data: ["email":email, "uid":res!.user.uid ]) { (error) in
            if error != nil {
                print("Problems with database")
            }
        }
        
        
                
        completion(true,(res?.user.email)!)
    }
}

func signInWithEmail(email: String,password : String,completion: @escaping (Bool,String)->Void){
    
    Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
        
        if err != nil{
            
            completion(false,(err?.localizedDescription)!)
            return
        }
        
        user.email = (res?.user.email)!
        user.password = password
        
//        do{
//            let decodedUser = try decoder.decode(User.self, from: temp)
//        }catch{
//            print("error in decoding")
//        }

        
        let currUserUID = Auth.auth().currentUser!.uid
        
        let currUser = Auth.auth().currentUser
        print(user.email)
        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: user.email, password: user.password)
        print(credential)
        currUser?.reauthenticate(with: credential) { args, error  in
          if let error = error {
            print(error)
          } else {
            print("reauthentificated")
          }
        }

        db.collection("users").getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                var count = 0
                for document in querySnapshot!.documents {
                    count += 1
                    print("\(document.documentID) => \(document.data())");
                    if currUserUID == document.data()["uid"] as! String { //it tries to find current user in documents (not efficient) TODO: find more efecient way
                        
                        user.name = document.data()["name"] as! String
                        user.surname = document.data()["surname"] as! String
                        
                        print(user.name)
                        print(user.surname)
                                                            
                        print("name and surname are setted")
                        break
                    }
                    
                }
                
                print("Count = \(count)");
            }
        }
        
        completion(true,(res?.user.email)!)
    }
    
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
