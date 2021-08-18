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
    .frame(width: .infinity, height: 3, alignment: .center)
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
    @State private var textRect = CGRect()
    @State private var show = false
    
    var body: some View {
        VStack(spacing: 0){
            line
            HStack{
                Text(withTitle)
                    .padding(.leading)
                    .padding(.top)
                    .font(.system(size: 28, weight: .heavy, design: .default))
                
                Spacer()
                Button(action: {
                    withAnimation{
                        self.show.toggle()
                    }
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
            .zIndex(2)
            .frame(height: 40)
            .padding(.bottom)
            
            
            VStack(spacing: 0){
                Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                    .font(.title)
                Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                Text("info bla bla lbal wefwe fw info bla bla lbal wefwe fw")
                
            }
            .zIndex(1)
            .background(GeometryGetter())
            .offset(y: show ? 0 : -textRect.height)
            .clipped()
            .onPreferenceChange(RectPreferenceKey.self) { self.textRect = $0 }
            
            
            // .transition(.move(edge: show ? .top : .bottom))
             //.transition(.slide)
            
        }
        .offset(y: 0)
        //.offset(y: show ? 0.0 : +textRect.height / 2.0)
        .animation(.easeIn(duration: 0.3))
    }
    
}

struct RectPreferenceKey: PreferenceKey {
    static var defaultValue = CGRect()
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
    
    typealias Value = CGRect
}

struct GeometryGetter: View {
    var body: some View {
        GeometryReader { geometry in
            return Rectangle()
                .fill(Color.clear)
                .preference(key: RectPreferenceKey.self, value:geometry.frame(in: .global))
        }
    }
}

struct InfoListParentFalse_Previews: PreviewProvider {
    static var previews: some View {
        InfoListParentFalse()
    }
}
