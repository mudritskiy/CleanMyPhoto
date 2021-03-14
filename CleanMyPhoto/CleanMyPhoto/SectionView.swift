////
////  SectionView.swift
////  CleanMyPhoto
////
////  Created by Volodymyr Mudrik on 13.03.2021.
////
//
//import SwiftUI
//
//struct SectionView: View {
//
//    @State var album: AlbumData
//    @State var section: AlbumSection
//
//    @State private var checked = false
//    @State private var trimValue: CGFloat = 0
//
//   let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
//
//    var body: some View {
//
//        HStack(alignment: VerticalAlignment.top) {
//
//            Rectangle()
//                .foregroundColor(Color.black.opacity(0.5))
//                .frame(width: 6)
//                .clipShape(RoundedRectangle(cornerRadius: 2))
//
//            VStack(alignment: HorizontalAlignment.leading) {
//                HStack(alignment: VerticalAlignment.center) {
//                    Text("\(section.name)")
//                        .font(.headline)
//                    Rectangle().frame(height: 1)
//                        .foregroundColor(Color.gray.opacity(0.5))
//                        .offset(x: -5)
//                }
//                Text("6 photo, 1 video (24 Mb)")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//
//            CheckBoxView(checked: $checked, trimValue: $trimValue)
//                .onTapGesture {
//                    if self.checked {
//                        withAnimation {
//                            self.checked.toggle()
//                            self.trimValue = 0
//                        }
//                    } else {
//                        withAnimation(.easeIn(duration: 0.3)) {
//                            self.checked.toggle()
//                            self.trimValue = 1
//                        }
//                    }
//                }
//                .offset(x: -5, y: 5)
//        }
//
//        LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
//            ForEach(section.range, id: \.self) { assetId in
//                if let asset = album.assets.filter { $0.id == assetId}.first {
//                    CellAssetView(asset: asset.asset)
//                }
//            }
//        }
//        .padding(.horizontal, 10)
//    }
//
//}
//
////struct SectionView_Previews: PreviewProvider {
////    static var previews: some View {
////        SectionView()
////    }
////}
