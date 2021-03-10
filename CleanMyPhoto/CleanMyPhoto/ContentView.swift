//
//  ContentView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import Photos
import SwiftUI

struct ContentView: View {
    
    /*
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    */
    var body: some View {
        
       let album = AlbumData()
       
        VStack {
            Text(String(album.assets.count))
            Image(uiImage: album.getImage(for: album.assets.first?.asset ?? PHAsset(), with: CGSize(width: 50, height: 50)))
                .resizable()
                .scaledToFit()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
