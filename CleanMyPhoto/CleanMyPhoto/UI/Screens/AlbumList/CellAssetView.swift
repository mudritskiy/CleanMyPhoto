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

        VStack(alignment: .leading) {

            ZStack(alignment: Alignment.top) {
                targetImage
                CheckBoxView(checked: checked, range: [assetWithData.id], size: 20)
                    .offset(x: 0, y: -10)
            }
            HStack {
                Text("\(assetWithData.asset.fileSize.readableSize)")
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
        .padding(.top, firstRow ? 25 : 0)
    }

}

extension CellAssetView {

    var targetImage: some View {
        GeometryReader { gr in
            Image(uiImage: assetWithData.asset.getImage(with: CGSize(width: assetWithData.asset.pixelWidth, height: assetWithData.asset.pixelHeight)))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: showingPopover ? 50 : 25))
//                .position(x: showingPopover ? gr.frame(in: CoordinateSpace.local).midX   : 640 , y: 150)
//                .scaleEffect(showingPopover ? 1.73 : 1)
//                .animation(.spring())
                .gesture(
                    LongPressGesture(minimumDuration: 0.5)
                        .updating($isDetectingPress) { currentState, gestureState, transaction in
                            gestureState = currentState
                        }
                        .onEnded { value in
                            self.album.zoomedAsset = assetWithData.id
//                            showingPopover.toggle()
                        }
                )
//                .onTapGesture {
//                        if self.album.zoomedAsset == nil {
//                            withAnimation(.easeOut(duration: 1)) {
//                          self.album.zoomedAsset = assetWithData.id
//                        }
//                    }
////                    showingPopover.toggle()
//                }
        }
        .scaledToFill()
    }

    var targetImage1: some View {
        GeometryReader { gr in
            Image(uiImage: assetWithData.asset.getImage(with: CGSize(width: assetWithData.asset.pixelWidth, height: assetWithData.asset.pixelHeight)))
                .resizable()

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
                Image(uiImage: self.assetWithData.asset.getFullImage())
                    .resizable()
                    .padding()
                    .scaledToFit()
                    .cornerRadius(25)
                    .onTapGesture {
                        showingPopover.toggle()
                    }

            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
    }

}

//struct CellAssetPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CellAssetView(sectionChecked: <#T##Binding<Bool>#>, asset: <#T##PHAsset#> asset: PHAsset())
//    }
//}
