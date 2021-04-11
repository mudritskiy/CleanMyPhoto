//
//  ClearView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 28.03.2021.
//

import SwiftUI

struct ClearView: View {

	@EnvironmentObject var album: AlbumData
	@State var zeroState: CGFloat = 0

	var body: some View {

		VStack(alignment: .leading, spacing: 0) {
			photos
			space
		}
	}
}

extension ClearView {

	var photos: some View {
		summaryView(name: "Photos", percentege: album.assetsCount.percentage, count: album.assetsCount.checked.description, total: album.assetsCount.all.description)
	}

	var space: some View {
		summaryView(name: "Space", percentege: album.sizeSum.percentage, count: album.sizeSum.checked.readableSize, total: album.sizeSum.all.readableSize.digits, of: album.sizeSum.all.readableSize.chars)

	}

}
extension ClearView {
	func summaryView(name: String, percentege: CGFloat, count: String, total: String, of totalType: String = "") -> some View {

		var body: some View {

			VStack(alignment: .leading, spacing: 0) {

				HStack(alignment: VerticalAlignment.bottom, spacing: nil) {
					Text("\(total)")
						.font(.custom("system", size: 80))
						.fontWeight(.bold)
						.foregroundColor(Color.ui.accent)
						.offset(y: 10)
					Text("\(totalType)")
						.font(.custom("system", size: 20))
						.fontWeight(.bold)
						.foregroundColor(Color.ui.accent)
						.offset(x: -10, y: -5)
					Text(name)
						.font(.system(size: 40, weight: Font.Weight.light, design: Font.Design.rounded))
						.font(.custom("system", size: 40))
						.fontWeight(.light)
						.foregroundColor(Color.ui.tint)
					Spacer()
				}

				GeometryReader { geometry in
					ZStack(alignment: .bottomLeading) {
						RoundedRectangle(cornerRadius: 5)
							.foregroundColor(Color.ui.backgound)
						RoundedRectangle(cornerRadius: 5)
							.foregroundColor(Color.ui.accent)
							.frame(width: geometry.size.width * percentege * zeroState, alignment: .leading)
							.animation(Animation.easeIn(duration: 2).delay(1))
					}
				}
				.frame(height: 10)

				HStack(alignment: VerticalAlignment.top) {
					Text("\(count)")
						.font(.custom("system", size: 20))
						.fontWeight(.light)
						.foregroundColor(Color.ui.accent)
					Text("selected")
						.font(.custom("system", size: 20))
						.fontWeight(.ultraLight)
						.foregroundColor(Color.ui.tint)
					Spacer()
				}
				.offset(x: 20, y: 5)


			}
			.padding(.horizontal, 20)
			.onAppear() {
				zeroState = 1
			}
			.onDisappear() {
				zeroState = 0
			}
		}

		return body
	}
}

struct ClearView_Previews: PreviewProvider {
	static var previews: some View {
		ClearView()
			.environmentObject(AlbumData())
	}
}
