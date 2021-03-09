//
//  ContentView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import Photos
import SwiftUI

struct ContentView: View {
    
    private var imageMain = UIImage()
//    @State private var imageMain = UIImage()
    private var assetCount = 0
    
    init() {
        createAlbum()
    }

    mutating func createAlbum() {
//        let options = PHFetchOptions()
//        options.predicate = NSPredicate(format: "title = %@", albumTitle)
        var localImage = UIImage()
        
        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum,
                                                                 subtype: .smartAlbumUserLibrary,
                                                                 options: nil)
        if let album = collection.firstObject {
         
            let options = PHFetchOptions()
//            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: ascending)]

            let assets: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: album, options: options)
            assetCount = assets.count

            if assets.count > 0 {
                let firstAsset = assets[0]
                let size = CGSize(width: 500, height: 500)
                PHImageManager.default().requestImage(for: firstAsset, targetSize: size, contentMode: .aspectFill, options: nil) {(image, _) -> Void in
                    if let imageUnwrapped = image {
                        localImage = imageUnwrapped}
                }
            }
            
            self.imageMain = localImage
           // Альбом уже есть, можем его использовать
        }


    }
    
    /*
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    */
    var body: some View {
        
        VStack {
            Text(String(self.assetCount))
            Image(uiImage: self.imageMain)
                .resizable()
                .scaledToFit()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        
        /*
        VStack {
            
            
            Image(uiImage: self.image)
                .resizable()
                .scaledToFit()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    Text("Photo library")
                        .font(.headline)
                }
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(20)
                .padding(.horizontal)
            }
            
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
    
         }
         */
        
    }
    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
