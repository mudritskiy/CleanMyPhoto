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
    @State private var expanded: Bool = true

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    let sectiocColor: Color = .white

    var body: some View {

        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            sectionHeaderTitleCount.offset(x: 0, y: 5)
            VStack(spacing: 0) {
                ZStack(alignment: Alignment.bottomLeading) {
                    HStack(alignment: VerticalAlignment.center) {
                        sectionHeaderTitle
                        Spacer()
                        sectionCheckbox
                    }
                }
                .frame(height: 25)
                Rectangle()
                    .frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(sectiocColor)
                if self.expanded {
                    cellGrid
                }
                bottomGridShape()
                    .frame(height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(sectiocColor)
            }
            .compositingGroup()
            .shadow(color: Color.color3.opacity(1.0), radius: 1, x: -1, y: -1)
            .shadow(color: Color.color5.opacity(0.3), radius: 1, x: 1, y: 1)

            HStack {
                Spacer()
                ZStack {
                    Circle()
                        .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 01)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down.circle")
                        .foregroundColor(Color.color5.opacity(0.5))
                        .font(.system(size: 15))
                        .rotationEffect(expanded ? .init(degrees: 180) : .zero)
                }
                .offset(x: -5, y: 28)
                .onTapGesture {
                    withAnimation(.interpolatingSpring(mass: 0.7, stiffness: 20, damping: 5.0, initialVelocity: 3.5)) {
                        self.expanded = !self.expanded
                    }
                }
            }

        }
//        .padding(.horizontal, 10)
    }

    private func rangeChecked(sectionRange: [UUID], checkedRange: Set<UUID>) -> Bool {
        let range = sectionRange.reduce(into: Set<UUID>(), { (result, object) in
            result.insert(object)
        })
        return range.isSubset(of: checkedRange)
    }
}

private extension SectionView {
    var cellGrid: some View {
        ZStack {
            sectiocColor
            LazyVGrid(columns: columns, alignment: .center, spacing: 20) {
                ForEach(section.range, id: \.self) { assetId in
                    if let assetWithData = album.assets.filter { $0.id == assetId}.first {
                        let firstRow = section.range.firstIndex(of: assetId) ?? 0 < 4
                        CellAssetView(assetWithData: assetWithData, firstRow: firstRow)
                    }
                }
            }.padding(.horizontal, 10)
        }
    }
}

private extension SectionView {
    var sectionCheckbox: some View {
        ZStack(alignment: Alignment.leading) {
            CheckBoxView(checked: checked, range: section.range, size: 15, showOverlay: true)
                .offset(x: -7, y: 0)
        }
    }

    var sectionHeaderTitle: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ZStack(alignment: .bottomLeading) {
                titleShape()
                    .frame(width: 150, height: 25, alignment: .leading)
                    .foregroundColor(sectiocColor)

                HStack {
                    Text("\(section.name)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.color5)
                    Text("\(section.subname)")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.color5)
                }
                .offset(x: 7, y: -2)
            }
        }
    }
    var sectionHeaderTitleCount: some View {
        VStack(alignment: HorizontalAlignment.leading) {
            ZStack(alignment: .bottomLeading) {
                let widthFirst: CGFloat = 150
                let offset1 = widthFirst - 20
                let offset2 = offset1 + 60

                if section.typeCount.videos > 0 {
                    titleShape()
                        .frame(width: 80, height: 17, alignment: .leading)
                        .foregroundColor(.color4)
                        .offset(x: offset2, y: -0)
                        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: -0)
                }
                if section.typeCount.photos > 0 {
                    titleShape()
                        .frame(width: 80, height: 20, alignment: .leading)
                        .foregroundColor(.color4)
                        .offset(x: offset1, y: -0)
                        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: -0)
                }
                if section.typeCount.photos > 0 {
                    Text("\(section.typeCount.photos) photos")
                        .font(.system(size: 11, weight: .thin))
                        .offset(x: offset1 + 25, y: -3)
                }
                if section.typeCount.videos > 0 {
                    Text("\(section.typeCount.videos) videos")
                        .font(.system(size: 11, weight: .ultraLight))
                        .offset(x: offset2 + 25, y: -3)
                }
            }
        }
    }
}



struct titleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let shift: CGFloat = rect.maxY / 1.5

        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.minX + 5, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: -180), endAngle: Angle(degrees: -90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - shift, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - shift, y: rect.minY + 5), radius: 5, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -30), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}

struct bottomGridShape: Shape {
    func path(in rect: CGRect) -> Path {
        let cornerRadius: CGFloat = 10
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

//struct SectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionView(section: AlbumSection(name: "test", range: []))
//    }
//}

