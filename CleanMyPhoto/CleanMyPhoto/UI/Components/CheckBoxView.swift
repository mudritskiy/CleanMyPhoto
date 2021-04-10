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

        let sizeInner = size * (showOverlay ? 0.9 : 1)

        ZStack {
            if !checked && showOverlay {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color.ui.accent.opacity(0.5))
            }
            Circle()
                .trim(from: 0, to: checked ? 1 : 0)
                .stroke(style: StrokeStyle(lineWidth: 3))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.ui.backgound)
                .overlay(
                    Circle()
                        .fill(checked ? Color.ui.accent : Color.ui.backgound)
                        .frame(width: sizeInner, height: sizeInner, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 9))
            }
        }
        .onTapGesture {
            withAnimation(.easeIn(duration: checked ? 0.3 : 0.3)) {
                if self.checked {
                    self.album.removeChecked(range: range)
                } else {
                    self.album.addChecked(range: range)
                }
            }
        }
    }
}

