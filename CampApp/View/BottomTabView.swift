//
//  BottomTabView.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 13.08.2021.
//

import SwiftUI

struct BottomTabView: View {
    
    @State private var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView) {
            CampsView()
                .tabItem {
                    Image("iosFlagOutline")
                    Text("Лагери")
                }
                .tag(0)
            HomeView()
                .tabItem {
                 //   Image(systemName: "2.square.fill")
                    Text("Главная")
                }
                .tag(1)
            UserPersonalView()
                .tabItem {
                    //Image(systemName: "3.square.fill")
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
