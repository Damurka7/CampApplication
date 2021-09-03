//
//  User.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 23.08.2021.
//

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
    
    init(email: String, password: String, name: String, surname: String) {
        self.email = email
        self.password = password
        self.name = ""
        self.surname = ""
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
