//
//  HomeView.swift
//  LoginUI
//
//  Created by Damir Nurtdinov on 05.08.2021.
//  Copyright © 2021 Ian Solomein. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView : View {
    
    var body : some View{
        
        VStack{
            
            Text("Home")
            Button(action: {
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }) {
                
                Text("Logout")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
