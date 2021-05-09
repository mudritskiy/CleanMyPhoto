//
//  PHAsset+.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 28.04.2021.
//

//import Foundation
import Photos
import SwiftUI

extension PHAsset {

	var fileSize: FileSizeDimension {
		get {
			let resource = PHAssetResource.assetResources(for: self)
			let fileSizeByte = resource.first?.value(forKey: "fileSize") as? FileSizeDimension ?? 0
			return fileSizeByte
		}
	}

	//	func getURL(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ responseURL : FileSizeDimension) -> Void)) {
	//		let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
	////		options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
	////			return true
	////		}
	//		mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
	//			var fileSize: FileSizeDimension = 0
	//			do {
	//				let fileSize1 = try contentEditingInput?.fullSizeImageURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).fileSize
	//				fileSize = FileSizeDimension(fileSize1!)
	////				print("file size: \(String(describing: fileSize))")
	//			} catch let error {
	//				fatalError("error: \(error)")
	//			}
	//			completionHandler(fileSize)
	//		})
	//	}

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
