//
//  Helper.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import Photos
import UIKit
import SwiftUI

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

extension Color {
    public static var color1: Color {
        return Color.init(#colorLiteral(red: 0.9245133996, green: 0.9296407104, blue: 0.9465822577, alpha: 1)) // #ecedf1
    }
    public static var color2: Color {
        return Color.init(#colorLiteral(red: 0.6509803922, green: 0.6705882353, blue: 0.7411764706, alpha: 1)) // #a6abbd
    }
    public static var color3: Color {
        return Color.init(#colorLiteral(red: 0.9803921569, green: 0.9843137255, blue: 1, alpha: 1)) // #fafbff
    }
    public static var color4: Color {
        return Color.init(#colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)) // #fafbff
    }
}

extension View {

    func ifTrue(_ condition:Bool, apply:(AnyView) -> (AnyView)) -> AnyView {
        if condition {
            return apply(AnyView(self))
        }
        else {
            return AnyView(self)
        }
    }

    func customShadow(shadowRadius: CGFloat, opacity: Double = 0.8) -> some View {
        self
            .shadow(color: Color.color2.opacity(opacity), radius: shadowRadius, x: shadowRadius, y: shadowRadius)
            .shadow(color: Color.color3.opacity(opacity), radius: shadowRadius, x: -shadowRadius, y: -shadowRadius)
    }
}
