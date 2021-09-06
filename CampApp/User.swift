//
//  User.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 23.08.2021.
//
import Firebase
import FirebaseAuth
import Foundation
import SwiftUI

class User {
    var name: String
    var email: String
    var password: String
    var campIsChosen: Bool = false
    var surname: String
    var age: Int?
    var photo: ImageWrapper?
    
    init(email: String) {
        self.email = email
        self.password = ""
        self.name = ""
        self.surname = ""
        print("USER IS CREATED")
        let currUserUID = Auth.auth().currentUser?.uid
        db.collection("users").getDocuments()
        {
            (querySnapshot, err) in
            
            if let err = err
            {
                print("Error getting documents: \(err)");
            }
            else
            {
                for document in querySnapshot!.documents {
                    if currUserUID == document.data()["uid"] as! String { //it tries to find current user in documents (not efficient) TODO: find more efecient way
                        db.collection("users").document(document.documentID).setData(["email" : email], merge: true)
                        let currUser = Auth.auth().currentUser
                        self.name = document.data()["name"] as! String
                        self.surname = document.data()["surname"] as! String
                        print("fields are downloaded")
                        break
                    }
                    
                }
            }
        }
    }
    
}

public struct ImageWrapper: Codable {
    
    public let photo: Data
    
    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
    
    //Deserialize the image:
    //UIImage(data: instanceOfSomeImage.photo)!
}
