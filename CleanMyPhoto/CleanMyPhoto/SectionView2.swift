//
//  SectionView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 13.03.2021.
//

import SwiftUI

struct SectionView2: View {

    @State var album: AlbumData
    @State var section: AlbumSection
    @Binding var checkedAssets: Set<UUID>

    @State private var checked = 0
    @State private var trimValue: CGFloat = 0

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {

        let shadowRadius: CGFloat = 1
        let checkboxContainerSize: CGFloat = 50

        ZStack {
            Color.color3
                .customShadow(shadowRadius: shadowRadius)

            HStack(alignment: VerticalAlignment.center) {

                VStack(alignment: HorizontalAlignment.leading) {
                    HStack(alignment: VerticalAlignment.center) {
                        Text("\(section.name)")
                            .font(.headline)
                        Rectangle().frame(height: 1)
                            .foregroundColor(Color.gray.opacity(0.5))
                            .offset(x: -5)
                    }
                    Text("6 photo, 1 video (24 Mb)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                ZStack(alignment: Alignment.leading) {

                    Rectangle()
                        .foregroundColor(Color.color4.opacity(1.0))
                        .frame(width: checkboxContainerSize)
                    Rectangle()
                        .foregroundColor(Color.color2.opacity(0.1))
                        .frame(width: 1)

                    CheckBoxView(
                        checked: $checked,
                        trimValue: $trimValue,
                        sectionChecked: $checked,
                        sectionTrimValue: $trimValue,
                        size: 20,
                        showOverlay: false)
                        
                        .onTapGesture {
                            if self.checked == 1 {
                                withAnimation {
                                    self.checked = 0
                                    self.trimValue = 0
                                }
                            } else {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    self.checked = 1
                                    self.trimValue = 1
                                }
                            }
                        }
                        .onChange(of: checked) { value in
                            if self.checked == 2 {
                                withAnimation {
//                                    self.checked = 0
                                    self.trimValue = 0
                                }
                            }

                        }
                        .offset(x: ((checkboxContainerSize - 20)/2))
                }
            }
        }
        .frame(height: 50)

        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(section.range, id: \.self) { assetId in
                if let assetWithData = album.assets.filter { $0.id == assetId}.first {
                    CellAssetView(
                        checkedAssets: $checkedAssets,
                        sectionChecked: $checked,
                        sectionTrimValue: $trimValue,
                        assetWithData: assetWithData)
                }
            }
        }
        .padding(.horizontal, 10)
    }

}

//struct SectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionView()
//    }
//}
