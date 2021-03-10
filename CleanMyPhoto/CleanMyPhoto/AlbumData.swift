//
//  AlbumData.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import UIKit
import Photos

struct AlbumData {
    
    var assets: [AssetWithData] = []
    
    init() {
        assets = fetchAssets()
    }
    
    private func fetchAssets() -> [AssetWithData] {
        
        var result: [AssetWithData] = []

        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        if let album = collection.firstObject {
         
            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: album, options: options)

            if fetchResult.count > 0 {
                fetchResult.enumerateObjects {
                    asset, _, _ in
                    let element = AssetWithData(asset)
                    result.append(element)
                }
                
            }
        }

        return result
    }

    func getImage(for asset:PHAsset, with size: CGSize) -> UIImage {
        
        var result = UIImage()
        
        PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: nil) {(image, _) -> Void in
            result = image ?? UIImage()
        }
        return result
    }
}

struct AssetWithData {
    
    let asset: PHAsset
    let creationDare: Date
    let size: Float
    
    init(_ asset: PHAsset) {
        self.asset = asset
        self.creationDare = asset.creationDate ?? Date()
        self.size = asset.fileSize
    }
    
}
