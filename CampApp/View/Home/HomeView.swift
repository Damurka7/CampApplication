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
            PhotosView()
                .frame(width: .infinity, height: 320)
            InfoListParentFalse()
            Spacer()
            
        }
        .ignoresSafeArea() //available only from iOS 14

    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
