//
//  CheckBoxView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 13.03.2021.
//

import SwiftUI

struct CheckBoxView: View {
    @EnvironmentObject var album: AlbumData

    var checked: Bool
    let range: [UUID]
    var size: CGFloat = 30
    var showOverlay: Bool = true

    var body: some View {

        let sizeInner = size * (showOverlay ? 0.75 : 1)
        let color: Color = (showOverlay ? Color.white : Color.color1).opacity(0.9)

        ZStack {
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: checked ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(checked ? .white : color)
                .overlay(
                    Circle()
                        .fill(checked ? .blue : color)
                        .frame(width: sizeInner, height: sizeInner, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
            }
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: checked ? 0.0 : 0.3)) {
                if self.checked {
                    self.album.removeChecked(range: range)
                } else {
                    self.album.addChecked(range: range)
                }
            }
        }
    }
}

