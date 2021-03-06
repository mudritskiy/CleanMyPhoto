//
//  AlbumData.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

//import Foundation
import UIKit
import Photos
import Foundation


class AlbumData: ObservableObject {
    
    var assets: [AssetWithData] = []
    var sections: [AlbumSection] = []
    @Published var checkedAssets: Set<UUID> = []
    @Published var zoomedAsset: UUID? = nil

	@Published var sectionType: SectionType = .date {
		didSet {
			sections = fetchSections(for: assets, by: sectionType)
		}
	}
	@Published var sortDesc: Bool = false {
		didSet {
			sections = fetchSections(for: assets, by: sectionType)
		}
	}

    init() {
        assets = fetchAssets()
        sections = fetchSections(for: assets, by: sectionType)
    }
    
    private func fetchAssets() -> [AssetWithData] {
        
        var result: [AssetWithData] = []

        let collection = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        if let album = collection.firstObject {

            let options = PHFetchOptions()
            options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

            let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: album, options: options)

            if fetchResult.count > 0 {
				let group = DispatchGroup()
                fetchResult.enumerateObjects {
                    asset, _, _ in
                   let element = AssetWithData(asset)
                    result.append(element)
                }
                
            }
        }

        return result
    }
    
	func getURL(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ responseURL : FileSizeDimension) -> Void)) {
		let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
		//		options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
		//			return true
		//		}
		mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
			var fileSize: FileSizeDimension = 0
			do {
				let fileSize1 = try contentEditingInput?.fullSizeImageURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).fileSize
				fileSize = FileSizeDimension(fileSize1!)
				//				print("file size: \(String(describing: fileSize))")
			} catch let error {
				fatalError("error: \(error)")
			}
			completionHandler(fileSize)
		})
	}

	private func fetchSections(for assets: [AssetWithData], by option: SectionType) -> [AlbumSection] {
        
        var sections: [AlbumSection] = []
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "MMMM d"
        let formatterYear = DateFormatter()
        formatterYear.dateFormat = "y"

        switch option {
        case .date:
            let sectionsRaw = assets
                .sorted { $0.creationDare < $1.creationDare }
                .map { $0.creationDare.removeTimeStamp() }
                .unique()
            sectionsRaw.forEach { sectionDate in
				let assetsRangeFull = assets
					.filter { $0.creationDare == sectionDate }
                let assetsRange = assetsRangeFull
                    .map { $0.id }
                let videos = assetsRangeFull
                    .filter { $0.asset.mediaType == .video }
                    .count
                let photos = assetsRangeFull
                    .filter { $0.asset.mediaType == .image }
                    .count
				let albumSection = AlbumSection(
					name: formatterDate.string(from: sectionDate),
					subname: formatterYear.string(from: sectionDate),
					range: assetsRange,
					typeCount: (photos: photos, videos: videos)
				)
				sections.append(albumSection)
            }
			if sortDesc {
				sections.reverse()
			}
			return sections
		case .size:
			let megaByte: Int64 = 1024 * 1024
			let sizeRanges: [Int64] = [0,1,2,5,10,50,100]
			var sectionsRaw: [(Int64, Int64)] = []
			for i in 1 ..< sizeRanges.count {
				let newElement = (sizeRanges[i-1] * megaByte, sizeRanges[i] * megaByte)
				sectionsRaw.append(newElement)
			}
			sectionsRaw.forEach { sectionSize in
				let assetsRange = assets
					.filter { $0.size >= sectionSize.0 && $0.size < sectionSize.1 }
					.sorted { sortDesc ? $0.size > $1.size : $0.size < $1.size }
					.map { $0.id }
				let videos = assets
					.filter { assetsRange.contains($0.id) && $0.asset.mediaType == .video }
					.count
				let photos = assets
					.filter { assetsRange.contains($0.id) && $0.asset.mediaType == .image }
					.count
				if photos + videos > 0 {
					let albumSection = AlbumSection(
						name: "< " + sectionSize.1.readableSize.digits,
						subname: sectionSize.1.readableSize.chars,
						range: assetsRange,
						typeCount: (photos: photos, videos: videos)
					)
					sections.append(albumSection)
				}
			}
			if sortDesc {
				sections.reverse()
			}
			return sections
		}
    }

    func addChecked(range: [UUID]) {
        range.forEach {
            checkedAssets.insert($0)
        }
    }

    func removeChecked(range: [UUID]) {
        range.forEach {
            checkedAssets.remove($0)
        }
    }

    func getAsset(by id: UUID?) -> PHAsset {
        guard let firstAsset = assets.filter({ $0.id == id }).first?.asset else { return PHAsset() }
        return firstAsset
    }

//	func fillSize( list: inout [AssetWithData]) {
//		let group = DispatchGroup()
//		for element in self.assets {
//			group.enter()
//			getSize(ofPhotoWith: element.asset, completionHandler: { (size) in
////				if let size = size {
//					element.size = size
////				}
//				group.leave()
//			})
//		}
//	}
//
//	func getSize(ofPhotoWith mPhasset: PHAsset, completionHandler : @escaping ((_ size : FileSizeDimension) -> Void)) {
//		let options: PHContentEditingInputRequestOptions = PHContentEditingInputRequestOptions()
//		mPhasset.requestContentEditingInput(with: options, completionHandler: { (contentEditingInput, info) in
//			var fileSize: FileSizeDimension = 0
//			do {
//				let fileSize1 = try contentEditingInput?.fullSizeImageURL?.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).fileSize
//				fileSize = FileSizeDimension(fileSize1!)
//			} catch let error {
//				fatalError("error: \(error)")
//			}
//			completionHandler(fileSize)
//		})
//	}

}

extension AlbumData {

    var photosCount: (all: Int, checked: Int, percentage: CGFloat) {
		let allAssetsInAlbum = self.assets.filter { $0.asset.mediaType == .image }.count
		let checkedAssetsInAlbum = self.assets.filter { checkedAssets.contains($0.id) && $0.asset.mediaType == .image }.count
        let percentageBetween = CGFloat(checkedAssetsInAlbum) / CGFloat(allAssetsInAlbum)
        return (allAssetsInAlbum, checkedAssetsInAlbum, percentageBetween )
    }

	var videosCount: (all: Int, checked: Int, percentage: CGFloat) {
		let allAssetsInAlbum = self.assets.filter { $0.asset.mediaType == .video }.count 
		let checkedAssetsInAlbum = self.assets.filter { checkedAssets.contains($0.id) && $0.asset.mediaType == .video }.count
		let percentageBetween = allAssetsInAlbum != 0 ? CGFloat(checkedAssetsInAlbum) / CGFloat(allAssetsInAlbum) : 0
		return (allAssetsInAlbum, checkedAssetsInAlbum, percentageBetween )
	}

    var sizeSum: (all: FileSizeDimension, checked: FileSizeDimension, percentage: CGFloat) {
		let allSize = self.assets.map { $0.size }.reduce(0, +)
        let checkedSize = self.assets.filter { checkedAssets.contains($0.id) }.map { $0.size }.reduce(0, +)
		let percentageBetween = allSize == 0 ? 0 : CGFloat(checkedSize) / CGFloat(allSize)
        return (allSize, checkedSize, percentageBetween)
    }
}

struct AssetWithData: Identifiable {
    
    let id = UUID()
    let asset: PHAsset
    let creationDare: Date
    let size: FileSizeDimension
    let duration: TimeInterval

	init(_ asset: PHAsset) {
        self.asset = asset
		self.creationDare = (asset.creationDate ?? Date()).removeTimeStamp()
        self.size = asset.fileSize
		self.duration = asset.duration
    }
}

enum SectionType {
    case date
	case size
}

struct AlbumSection: Identifiable {
    let id = UUID()
    let name: String
    let subname: String
    let range: [UUID]
    let typeCount: (photos: Int, videos: Int)
}
