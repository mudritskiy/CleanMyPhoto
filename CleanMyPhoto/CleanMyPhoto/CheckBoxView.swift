//
//  CheckBoxView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 13.03.2021.
//

import SwiftUI

struct CheckBoxView: View {

    @Binding var checked: Int
    @Binding var trimValue: CGFloat

    @Binding var sectionChecked: Int
    @Binding var sectionTrimValue: CGFloat

    @State var size: CGFloat = 30
    @State var showOverlay: Bool = true

    var animatbleData: CGFloat {
        get { trimValue }
        set { trimValue = newValue }
    }

    var body: some View {

        let sizeInner = size * (showOverlay ? 0.75 : 1)
        let opacityUnchecked: Double = 0.9
        let color: Color = (showOverlay ? Color.white : Color.color1).opacity(opacityUnchecked)

        let checkState = checked ==  1 || sectionChecked == 1
        let trimState = max(trimValue, sectionTrimValue)

        ZStack {
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: trimState)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(checkState ? .white : color)
                .overlay(
                    Circle()
                        .fill(checkState ? .blue : color)
                .frame(width: sizeInner, height: sizeInner, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
            if checkState {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.system(size: 13))
            }
        }
    }
}

