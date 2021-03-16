//
//  AlbumData.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import UIKit
import Photos

class AlbumData: ObservableObject {
    
    var assets: [AssetWithData] = []
    var sections: [AlbumSection] = []
    @Published var checkedAssets: Set<UUID> = []

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
        let formatter = DateFormatter()
        formatter.dateFormat = "y, MMMM d"
        
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
                sections.append(AlbumSection(name: formatter.string(from: sectionDate), range: assetsRange))
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
}

struct AssetWithData: Identifiable {
    
    let id = UUID()
    let asset: PHAsset
    let creationDare: Date
    let size: Float
    
    init(_ asset: PHAsset) {
        self.asset = asset
        self.creationDare = asset.creationDate ?? Date()
        self.size = asset.fileSize
    }
    
}

enum SectionType {
    case date
}

struct AlbumSection: Identifiable {
    let id = UUID()
    let name: String
    let range: [UUID]
}
