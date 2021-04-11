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

    init() {
        assets = fetchAssets()
        sections = fetchSections(for: assets, by: .date)
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
                let assetsRange = assets
                    .filter { $0.creationDare.removeTimeStamp() == sectionDate }
                    .map { $0.id }
                let videos = assets
                    .filter { assetsRange.contains($0.id) && $0.asset.mediaType == .video }
                    .count
                let photos = assets
                    .filter { assetsRange.contains($0.id) && $0.asset.mediaType == .image }
                    .count
                sections.append(AlbumSection(name: formatterDate.string(from: sectionDate), subname: formatterYear.string(from: sectionDate), range: assetsRange, typeCount: (photos: photos, videos: videos)))
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
}

extension AlbumData {

    var assetsCount: (all: Int, checked: Int, percentage: CGFloat) {
        let allAssetsInAlbum = self.assets.count
        let checkedAssetsInAlbum = self.checkedAssets.count
        let percentageBetween = CGFloat(checkedAssetsInAlbum) / CGFloat(allAssetsInAlbum)
        return (allAssetsInAlbum, checkedAssetsInAlbum, percentageBetween )
    }

    var sizeSum: (all: FileSizeDimension, checked: FileSizeDimension, percentage: CGFloat) {
        let allSize = self.assets.map { $0.size }.reduce(0, +)
        let checkedSize = self.assets.filter { checkedAssets.contains($0.id) }.map { $0.size }.reduce(0, +)
		let percentageBetween = CGFloat(checkedSize) / CGFloat(allSize)
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
        self.creationDare = asset.creationDate ?? Date()
        self.size = asset.fileSize
        self.duration = asset.duration
    }
}

enum SectionType {
    case date
}

struct AlbumSection: Identifiable {
    let id = UUID()
    let name: String
    let subname: String
    let range: [UUID]
    let typeCount: (photos: Int, videos: Int)
}
