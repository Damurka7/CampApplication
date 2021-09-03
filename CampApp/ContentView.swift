//
//  ContentView.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 11.08.2021.
//

import Firebase
import FirebaseAuth
import SwiftUI

struct ContentView: View {
    
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        
        VStack{
            
            if status{
                BottomTabView()
            }
            else{
                SignInView()
            }
            
            
        }.animation(.spring())
            .onAppear {
                
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
