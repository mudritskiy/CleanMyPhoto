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
    
    var fileSize: FileSizeDimension {
        get {
            let resource = PHAssetResource.assetResources(for: self)
            let fileSizeByte = resource.first?.value(forKey: "fileSize") as? FileSizeDimension ?? 0
            return fileSizeByte
        }
    }

    var readbleDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .dropLeading
        return formatter.string(from: self.duration) ?? ""
    }

    func getImage(with size: CGSize) -> UIImage {
        var result = UIImage()
        PHImageManager.default().requestImage(for: self, targetSize: size, contentMode: .aspectFit, options: nil) {(image, _) -> Void in
            result = image ?? UIImage()
        }
        return result
    }

    func getFullImage() -> UIImage {
        let asset = self
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var resultImage = UIImage()
        options.isSynchronous = true
        manager.requestImage(for: self, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: options, resultHandler: {(result, void) -> Void in
            resultImage = result!
        })
        return resultImage
    }
}

typealias FileSizeDimension = Int64

extension FileSizeDimension {
    var readableSize: String {
        get {
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = .useAll
			formatter.countStyle = .file
            formatter.includesUnit = true
            formatter.isAdaptive = true
            formatter.allowsNonnumericFormatting = false
			return formatter.string(fromByteCount: self).capitalized
        }
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

extension String {
	var chars: String {
		guard let result = components(separatedBy: CharacterSet.decimalDigits).last else { return "" }
			return result

	}
    var digits: String {
		self.capitalized.replacingOccurrences(of: self.chars, with: "").trimmingCharacters(in: .whitespaces)
//		components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}

extension Color {

    static let ui = Color.UI()

    struct UI {
        //TODO: select final pattern

        private let PurlePattern = [#colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1),#colorLiteral(red: 0.8980392157, green: 0.9058823529, blue: 0.9607843137, alpha: 1),#colorLiteral(red: 0.4078431373, green: 0.3843137255, blue: 0.5843137255, alpha: 1)]
        private let GreyPatter = [#colorLiteral(red: 0.9803921569, green: 0.9843137255, blue: 1, alpha: 1),#colorLiteral(red: 0.9245133996, green: 0.9296407104, blue: 0.9465822577, alpha: 1),#colorLiteral(red: 0.6509803922, green: 0.6705882353, blue: 0.7411764706, alpha: 1)]

        private var appColorPattern: [UIColor] { PurlePattern }

        var backgound: Color { Color.init(appColorPattern[0]) }
        var tint: Color { Color.init(appColorPattern[1]) }
        var accent: Color { Color.init(appColorPattern[2]) }

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
            .shadow(color: Color.ui.backgound.opacity(opacity), radius: shadowRadius, x: shadowRadius, y: shadowRadius)
            .shadow(color: Color.ui.tint.opacity(opacity), radius: shadowRadius, x: -shadowRadius, y: -shadowRadius)
    }
}

