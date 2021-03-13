//
//  Helper.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import Photos
import UIKit

extension PHAsset {
    
    var fileSize: Float {
        get {
            let resource = PHAssetResource.assetResources(for: self)
            let fileSizeByte = resource.first?.value(forKey: "fileSize") as? Float ?? 0
            let fileSizeMb = fileSizeByte / ( 1024.0 * 1024.0)
            return fileSizeMb
        }
    }

    func getImage(with size: CGSize) -> UIImage {
        var result = UIImage()
        PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: .aspectFill, options: nil) {(image, _) -> Void in
            result = image ?? UIImage()
        }
        return result
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element>  = []
        return filter { seen.insert($0).inserted }
    }
}

extension Date {
    func removeTimeStamp() -> Date {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        guard let date = Calendar.current.date(from: dateComponents) else {
            // TODO: need hadler
            return self
        }
        return date
    }
}
