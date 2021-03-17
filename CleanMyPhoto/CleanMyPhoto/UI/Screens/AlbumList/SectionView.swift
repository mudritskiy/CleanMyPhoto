//
//  SectionView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 13.03.2021.
//

import SwiftUI

struct SectionView: View {

    @EnvironmentObject var album: AlbumData
    var section: AlbumSection
    private var checked: Bool { rangeChecked(sectionRange: section.range, checkedRange: album.checkedAssets) }

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {

        let shadowRadius: CGFloat = 1
        let checkboxContainerSize: CGFloat = 50

        ZStack {
            Color.color3
                .customShadow(shadowRadius: shadowRadius)

            HStack(alignment: VerticalAlignment.center) {

                Rectangle()
                    .foregroundColor(Color.color2.opacity(0.1))
                    .frame(width: 1)

                VStack(alignment: HorizontalAlignment.leading) {
                    HStack(alignment: VerticalAlignment.center) {
                        Text("\(section.name)")
                            .font(.headline)
                        //                        Rectangle().frame(height: 1)
                        //                            .foregroundColor(Color.gray.opacity(0.5))
                        //                            .offset(x: -5)
                    }
                    Text("6 photo, 1 video (24 Mb)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                ZStack(alignment: Alignment.leading) {

                    Rectangle()
                        .foregroundColor(Color.color4.opacity(1.0))
                        .frame(width: checkboxContainerSize)
                    Rectangle()
                        .foregroundColor(Color.color2.opacity(0.1))
                        .frame(width: 1)

                    CheckBoxView(checked: checked, range: section.range, size: 20, showOverlay: false)
                        .offset(x: (checkboxContainerSize - 20 )/2)
                }
            }
        }
        .frame(height: 50)

        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
            ForEach(section.range, id: \.self) { assetId in
                if let assetWithData = album.assets.filter { $0.id == assetId}.first {
                    CellAssetView(assetWithData: assetWithData)
                }
            }
        }
        .padding(.horizontal, 10)
    }

    private func rangeChecked(sectionRange: [UUID], checkedRange: Set<UUID>) -> Bool {
        let range = sectionRange.reduce(into: Set<UUID>(), { (result, object) in
            result.insert(object)
        })
        return range.isSubset(of: checkedRange)
    }
}


//struct SectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionView()
//    }
//}
