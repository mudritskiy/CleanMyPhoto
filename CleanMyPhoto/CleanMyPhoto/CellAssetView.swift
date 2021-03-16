//
//  CellAssetPreview.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import SwiftUI
import Photos

struct CellAssetView: View {

    @EnvironmentObject var album: AlbumData
    private var checked: Bool { album.checkedAssets.contains(assetWithData.id) }

    let assetWithData: AssetWithData

    var body: some View {

        let asset: PHAsset = assetWithData.asset
        let assetId: UUID = assetWithData.id

        VStack(alignment: .leading) {

            ZStack(alignment: Alignment.topTrailing) {

                let shadowRadius: CGFloat = 2

                GeometryReader { gr in
                    Image(uiImage: asset.getImage(with: CGSize(width: 500, height: 500)))
                        .resizable()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .customShadow(shadowRadius: shadowRadius)
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
                    //                        .overlay(RoundedRectangle(cornerRadius: 15.0).stroke(Color.color1, lineWidth: 1.0))

                }
                .aspectRatio(1, contentMode: .fit)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                CheckBoxView(checked: checked, range: [assetId], size: 30)
                    .customShadow(shadowRadius: shadowRadius, opacity: 0.5)
                    .offset(x: 10, y: -10)
            }
            Text("\(asset.fileSize)")
        }
        .padding(5)

    }

}

//struct CellAssetPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CellAssetView(sectionChecked: <#T##Binding<Bool>#>, asset: <#T##PHAsset#> asset: PHAsset())
//    }
//}
