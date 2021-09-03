//
//  PhotosView.swift
//  CampApp
//
//  Created by Damir Nurtdinov on 14.08.2021.
//

import SwiftUI

var currPhotosArray: Array<UIImage> = [UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!]

var mainPhotosArray: Array<UIImage> = [UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!,UIImage(named: "img2")!]


struct PhotosView: View {
    //TODO: it shows photos withoout last one
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 270){
                ForEach(user.campIsChosen ? currPhotosArray : mainPhotosArray, id: \.self) { item in
                    GeometryReader { geometry in
                        MainPhoto(img: item)
                            .rotation3DEffect(
                                Angle(degrees: Double(geometry.frame(in: .global).minX-20)/(-10)), axis: (x:0, y:10, z:0))
                            .padding(.top, 50)
                            
                    }
                }
            }
        }
    }
}

struct MainPhoto: View {
    
    var img: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: img)
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .background(Color(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)))
        .frame(width: .infinity, height: 250)
    }
}


struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
