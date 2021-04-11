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

		ZStack {
			VStack {
				header
				Spacer()

			}
			VStack(alignment: .leading, spacing: 0) {
				photos
				videos
				space
			}
		}
		.ignoresSafeArea()
	}
}

extension ClearView {

	var photos: some View {
		summaryView(name: "Photos", percentage: album.photosCount.percentage, count: album.photosCount.checked.description, total: album.photosCount.all.description)
	}

	var videos: some View {
		summaryView(name: "Videos", percentage: album.videosCount.percentage, count: album.videosCount.checked.description, total: album.videosCount.all.description)
	}

	var space: some View {
		summaryView(name: "Space", percentage: album.sizeSum.percentage, count: album.sizeSum.checked.readableSize, total: album.sizeSum.all.readableSize.digits, of: album.sizeSum.all.readableSize.chars)
	}

	var header: some View {
		ZStack(alignment: Alignment.top) {
			headerShape()
				.frame(height: 30)
				.foregroundColor(Color.ui.accent.opacity(0.2))
				.shadow(color: Color.ui.accent.opacity(0.2), radius: 2)
				.offset(y: 100)
			headerShape()
				.frame(height: 20)
				.foregroundColor(Color.ui.accent.opacity(0.5))
				.shadow(color: Color.ui.accent.opacity(0.5), radius: 2)
				.offset(y: 100)
			Rectangle()
				.frame(height: 100)
				.foregroundColor(Color.ui.accent)
				.shadow(color: Color.ui.accent, radius: 2)

			Text("Summary".uppercased())
				.font(.system(size: 60, weight: .semibold, design: .rounded))
				.foregroundColor(Color.ui.tint)
				.opacity(zeroState == 0 ? 0 : 0.05)
				.offset(y: 20)
				.animation(Animation.easeIn(duration: 0.5).delay(0.3))
			Text("Summary")
				.font(.system(size: 40, weight: .light, design: .rounded))
				.foregroundColor(Color.ui.tint)
				.opacity(0.8)
				.offset(y: zeroState == 0 ? -45 : 45)
				.animation(Animation.easeIn(duration: 0.3).delay(0.3))
		}

	}
}
extension ClearView {
	func summaryView(name: String, percentage: CGFloat, count: String, total: String, of totalType: String = "") -> some View {

		var body: some View {

			VStack(alignment: .leading, spacing: 0) {

				HStack(alignment: VerticalAlignment.bottom, spacing: nil) {
					Text("\(total)")
						.font(.custom("system", size: 60))
						.fontWeight(.bold)
						.foregroundColor(Color.ui.accent)
						.offset(y: 6)
					Text("\(totalType)")
						.font(.custom("system", size: 20))
						.fontWeight(.bold)
						.foregroundColor(Color.ui.accent)
						.offset(x: -6, y: -5)
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
							.frame(width: geometry.size.width * percentage * zeroState, alignment: .leading)
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
			.padding(.vertical, 10)
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

struct headerShape: Shape {
	func path(in rect: CGRect) -> Path {
		var path = Path()

		path.move(to: CGPoint(x: rect.minX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

		return path
	}
}


struct ClearView_Previews: PreviewProvider {
	static var previews: some View {
		ClearView()
			.environmentObject(AlbumData())
	}
}
