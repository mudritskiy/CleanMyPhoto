//
//  Helper.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import Photos
import UIKit
import SwiftUI

typealias FileSizeDimension = Int64

extension FileSizeDimension {
    var readableSize: String {
        get {
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = .useAll
			formatter.countStyle = .memory
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
		private let Pattern1 = [#colorLiteral(red: 0.9058823529, green: 0.8705882353, blue: 0.7843137255, alpha: 1),#colorLiteral(red: 0.7960784314, green: 0.6862745098, blue: 0.5294117647, alpha: 1),#colorLiteral(red: 0.4941176471, green: 0.5411764706, blue: 0.5921568627, alpha: 1),#colorLiteral(red: 0.1882352941, green: 0.2784313725, blue: 0.368627451, alpha: 1)] // https://colorhunt.co/palette/207398
		private let Pattern2 = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),#colorLiteral(red: 0.9764705882, green: 0.9647058824, blue: 0.968627451, alpha: 1),#colorLiteral(red: 1, green: 0.9098039216, blue: 0.8392156863, alpha: 1),#colorLiteral(red: 1, green: 0.5921568627, blue: 0.1137254902, alpha: 1)] // https://colorhunt.co/palette/167224

        private var appColorPattern: [UIColor] { Pattern2 }

        var backgound: Color { Color.init(appColorPattern[0]) }
        var tint: Color { Color.init(appColorPattern[1]) }
        var foreground: Color { Color.init(appColorPattern[2]) }
		var accent: Color { Color.init(appColorPattern[3]) }

    }
}
