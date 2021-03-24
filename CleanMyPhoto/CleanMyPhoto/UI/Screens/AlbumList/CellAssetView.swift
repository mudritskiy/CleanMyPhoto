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
    @GestureState private var isDetectingPress = false
    @State private var showingPopover = false
    @Environment(\.presentationMode) var presentationMode
    private var checked: Bool { album.checkedAssets.contains(assetWithData.id) }

    let assetWithData: AssetWithData
    let firstRow: Bool

    var body: some View {

        let asset: PHAsset = assetWithData.asset
        let assetId: UUID = assetWithData.id

        VStack(alignment: .leading) {

            ZStack(alignment: Alignment.top) {

                GeometryReader { gr in
                    Image(uiImage: asset.getImage(with: CGSize(width: asset.pixelWidth, height: asset.pixelHeight)))
                        .gesture(
                            LongPressGesture(minimumDuration: 0.5)
                                .updating($isDetectingPress) { currentState, gestureState, transaction in
                                    gestureState = currentState
                                }
                                .onEnded { value in
                                    showingPopover.toggle()
                                }
                        )
                }
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .popover(isPresented: $showingPopover, attachmentAnchor: .point(UnitPoint.topLeading), arrowEdge: .top) {
                    //                        .popover(isPresented: $showingPopover) {
                    GeometryReader { gr in
                        Image(uiImage: loopedImage)
                            .resizable()
                            .padding()
                            .scaledToFit()
                            .cornerRadius(25)
                            .onTapGesture {
                                showingPopover.toggle()
                            }

                    }
                }

                CheckBoxView(checked: checked, range: [assetId], size: 20)
                    .offset(x: 0, y: -10)
            }
            HStack {
                Text("\(assetWithData.asset.readableSize)")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.color5)
                    .offset(x: 5, y: -5)
                Spacer()
                if assetWithData.duration > 0 {
                    Text("\(assetWithData.asset.readbleDuration)")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundColor(.color5)
                        .offset(x: -5, y: -5)
                }
            }
        }
        .padding(.leading, 5)
        .padding(.top, firstRow ? 25 : 0)
        .padding(.trailing, 5)
    }

}

extension CellAssetView {
    var loopedImage: UIImage {
        let asset = self.assetWithData.asset
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        var resultImage = UIImage()
        options .isSynchronous = true
        manager.requestImage(for: self.assetWithData.asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: options, resultHandler: {(result, void) -> Void in
            resultImage = result!
        })
        return resultImage
    }
}

//struct CellAssetPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CellAssetView(sectionChecked: <#T##Binding<Bool>#>, asset: <#T##PHAsset#> asset: PHAsset())
//    }
//}
