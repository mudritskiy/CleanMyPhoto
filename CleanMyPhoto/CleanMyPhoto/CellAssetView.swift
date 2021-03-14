//
//  CellAssetPreview.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import SwiftUI
import Photos

struct CellAssetView: View {

    @State private var checked: Int = 0
    @State private var trimValue: CGFloat = 0

    @Binding var checkedAssets: Set<UUID>

    @Binding var sectionChecked: Int
    @Binding var sectionTrimValue: CGFloat

    let assetWithData: AssetWithData

    var body: some View {

        let asset: PHAsset = assetWithData.asset
        let assetId: UUID = assetWithData.id

        VStack(alignment: .leading) {

            ZStack(alignment: Alignment.topTrailing) {

                let shadowRadius: CGFloat = 2
                var checkTap = false

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

                CheckBoxView(
                    checked: $checked,
                    trimValue: $trimValue,
                    sectionChecked: $sectionChecked,
                    sectionTrimValue: $sectionTrimValue,
                    size: 30)

                    .customShadow(shadowRadius: shadowRadius, opacity: 0.5)
                    .offset(x: 10, y: -10)
                    .onTapGesture {
                        if self.checked > 0 {
                            withAnimation {
                                self.checked = 0
                                self.trimValue = 0
                            }
                            self.checkedAssets.remove(assetId)
                        } else {
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.checked = 1
                                self.trimValue = 1
                            }
                            self.checkedAssets.insert(assetId)
                        }
                    }

                    .onChange(of: sectionChecked) { value in
                        print(checkTap)
                        if value == 1 && self.checked == 0 {
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.checked = 1
                                self.trimValue = 1
                            }
                            self.checkedAssets.insert(assetId)
                            print(1)
                        }
                        if value == 0 && self.checked > 0 {
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.checked = 0
                                self.trimValue = 0
                            }
                            self.checkedAssets.remove(assetId)
                            print(2)
                        }
                    }
                    .onChange(of: checked) { value in
                        if self.sectionChecked > 0 && value == 0 {
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.sectionChecked = 2
                                self.sectionTrimValue = 0
                            }
                            checkTap.toggle()
                            print(3)
                            print(checkTap)
                        }
                    }

            }

            Text("\(asset.fileSize)")
        }
        .padding(5)
    }
}

func animatCheck() {
    // TODO: implement animation fo check

}

//struct CellAssetPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        CellAssetView(sectionChecked: <#T##Binding<Bool>#>, asset: <#T##PHAsset#> asset: PHAsset())
//    }
//}
