//
//  Helper.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import Photos

extension PHAsset {
    var fileSize: Float {
        get {
            let resource = PHAssetResource.assetResources(for: self)
            let fileSizeByte = resource.first?.value(forKey: "fileSize") as? Float ?? 0
            let fileSizeMb = fileSizeByte / ( 1024.0 * 1024.0)
            return fileSizeMb
        }
    }
}
