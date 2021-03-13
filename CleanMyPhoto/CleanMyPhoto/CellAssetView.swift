//
//  CellAssetPreview.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 10.03.2021.
//

import SwiftUI
import Photos

struct CellAssetView: View {

    @State private var checked = false
    @State private var trimValue: CGFloat = 0

    let asset: PHAsset

    var body: some View {

        VStack(alignment: .leading) {

            ZStack(alignment: Alignment.topTrailing) {

                GeometryReader { gr in
                    Image(uiImage: asset.getImage(with: CGSize(width: 500, height: 500)))
                        .resizable()
                        .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        .overlay(RoundedRectangle(cornerRadius: 10.0).stroke(Color.white, lineWidth: 1.0))
                        .shadow(radius: 2)
                }
                .aspectRatio(1, contentMode: .fit)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                CheckBoxView(checked: $checked, trimValue: $trimValue)
                    .onTapGesture {
                        if self.checked {
                            withAnimation {
                                self.checked.toggle()
                                self.trimValue = 0
                            }
                        } else {
                            withAnimation(.easeIn(duration: 0.3)) {
                                self.checked.toggle()
                                self.trimValue = 1
                            }
                        }
                    }
                    .offset(x: -5, y: 5)
            }

            Text("\(asset.fileSize)")
        }
        .padding(5)
    }
}

struct CellAssetPreview_Previews: PreviewProvider {
    static var previews: some View {
        CellAssetView(asset: PHAsset())
    }
}
