//
//  CheckBoxView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 13.03.2021.
//

import SwiftUI

struct CheckBoxView: View {

    @Binding var checked: Bool
    @Binding var trimValue: CGFloat

    let opacityUnchecked: Double = 0.8

    var animatbleData: CGFloat {
        get { trimValue }
        set { trimValue = newValue }
    }

    var body: some View {

        let size: CGFloat = 30
        let sizeInner = size * 0.75

        ZStack {
            Circle()
                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: trimValue)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: size, height: size, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(checked ? .white : Color.white.opacity(opacityUnchecked))
                .shadow(radius: 5)
                .overlay(
                    Circle()
                        .fill(checked ? .green : Color.white.opacity(opacityUnchecked))
                        .frame(width: sizeInner, height: sizeInner, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/))
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
            }
        }
    }
}

