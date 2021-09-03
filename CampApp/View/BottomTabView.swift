//
//  BottomTabView.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 13.08.2021.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseDatabase

var user = User(email: (Auth.auth().currentUser?.email)!)

struct BottomTabView: View {
    
    @State private var selectedView = 1
    
    
    var body: some View {
        TabView(selection: $selectedView) {
            CampsView()
                .tabItem {
                    Image(systemName: "flag")
                    Text("Лагери")
                }
                .tag(0)
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Главная")
                }
                .tag(1)
                
            UserPersonalView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Кабинет")
                }
                .tag(2)
        }
        .font(.headline)
    }
}

struct BottomTabView_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabView()
    }
}
