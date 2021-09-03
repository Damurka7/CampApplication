//
//  InfoListParentFalse.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 17.08.2021.
//

import SwiftUI

var line: some View {
    VStack {
        Rectangle()
            .fill(Color.black)
            .frame(height: 2)
    }
    .frame(height: 3)
}

struct InfoListParentFalse: View {
    
    
    var body: some View {
        ScrollView{
            Row(withTitle: "Как выбрать лагерь?")
            
            Row(withTitle: "Как записаться?")
            
            Row(withTitle: "Что взять с собой?")
            
        }
    }
}


struct Row: View {
    
    var withTitle: String
    @State private var show = false
    
    var body: some View {
        ZStack{
            
            VStack{
                
                VStack(spacing: 0){
                    line
                        .offset(x: 0, y: 20)
                    HStack{
                        Text(withTitle)
                            .padding(.leading)
                            .padding(.top)
                            .font(.system(size: 28, weight: .heavy, design: .default))
                        
                        Spacer()
                        
                        Button(action: {
                            self.show.toggle()
                        }
                        , label: {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding()
                                .foregroundColor(.black)
                                .rotationEffect(show ? .init(degrees: 90) : .zero)
                            
                        })
                        .padding(.top)
                        
                    }
                }
                .zIndex(1)
                .background(Color.white)
                .opacity(1)
                .frame(width: .infinity, height: 40)
                .padding(.bottom)
                
                
                VStack{
                    if show {
                        VStack(spacing: 0){
                            Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                                .font(.title)
                            Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                            Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                            
                        }
                        .transition(.move(edge: .top))
                    }
                }
                
            }
            
        }
        .clipped()
        .animation(.easeIn(duration: 0.3))
    }
    
}

struct InfoListParentFalse_Previews: PreviewProvider {
    static var previews: some View {
        if user.campIsChosen {
            //TODO: create new list
        }
        else{
            InfoListParentFalse()
        }
    }
}
