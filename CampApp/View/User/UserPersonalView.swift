//
//  UserPersonalView.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 13.08.2021.
//

import Firebase
import FirebaseAuth
import SwiftUI
import UIKit

struct UserPersonalView: View{
    var tempUser: Data? = nil
    @State var email = user.email
    @State var name = user.name
    @State var surname = user.surname
    let db = Firestore.firestore()
    @State var editMode = false
    
    
   // let currUserUID = "XHBaC8MpNgONmHU4WOMayqEc7U12"
    let currUserUID = Auth.auth().currentUser?.uid
   // user = User(email: (Auth.auth().currentUser?.email)!, password: " ", name: "Name", surname: "Surname")

    
    var body: some View {
        VStack {
            Button(action: {
                self.editMode.toggle()
                if !editMode{
                    print(currUserUID)
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
                                    db.collection("users").document(document.documentID).setData(["email" : email], merge: true)
                                    let currUser = Auth.auth().currentUser
                                    print(user.email)
                                    var credential: AuthCredential = EmailAuthProvider.credential(withEmail: user.email, password: user.password)
                                    print(credential)
                                    currUser?.reauthenticate(with: credential) { args, error  in
                                      if let error = error {
                                        print(error)
                                      } else {
                                        print("reauthentificated")
                                      }
                                    }
                                    user.email = email
                                    currUser!.updateEmail(to: email) { error in
                                           if let error = error {
                                               print(error)
                                           } else {
                                               print("email has CHANGED")
                                           }
                                       }
                                    db.collection("users").document(document.documentID).setData(["name" : name], merge: true)
                                    user.name = name
                                    print(user.name)
                                    db.collection("users").document(document.documentID).setData(["surname" : surname], merge: true)
                                    user.surname = surname
                                                
//                                    do {
//                                        let savedUser = try encoder.encode(user)
//                                        tempUser = savedUser
//                                        print(savedUser)
//                                    }catch{
//                                        print("Error in encoder")
//                                    }
                                    break
                                }
                                
                            }
                            
                            print("Count = \(count)");
                        }
                    }
                }else{
                    name = user.name
                    surname = user.surname
                    print(name)
                    print(surname)
                }
            }) {
                Text(editMode ? "Done" : "Edit").font(.system(size: 20)).fontWeight(.light)
                    .foregroundColor(Color.blue)
            }
            VStack{
                if editMode {
                    TextField("Имя", text: $name)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    TextField("Фамилия", text: $surname)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    TextField("Электронная почта", text: $email)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                } else {
                    
                    Text(name)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text(surname)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                    Text(email)
                        .font(.system(size: 20))
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }) {
                Text("Logout")
            }
            
        }
    }
}


func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}

struct UserPersonalView_Previews: PreviewProvider {
    static var previews: some View {
        UserPersonalView()
    }
}
