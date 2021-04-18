//
//  ContentView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import Photos
import SwiftUI

struct AlbumList: View {

	@EnvironmentObject var album: AlbumData
	@State var scaleGrade: CGFloat = 0.33
	@State private var Sorting: Int = 0
	@State var showMenu: Bool = false

	var body: some View {

		ZStack(alignment: Alignment.center) {
			Color.ui.backgound.ignoresSafeArea(.all)
			ScrollView {
				LazyVStack(alignment: .leading, spacing: 15) {
					ForEach(album.sections, id: \.id) { section in
						Section() {
							SectionView(section: section)
								.padding(.trailing, 10)
						}
					}
				}
			}
			.padding(.horizontal, 10)
			.blur(radius: album.zoomedAsset == nil ? 0 : 2)
			.animation(.spring())

			HStack {
				Spacer()
				ZStack {
					Circle()
						.trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, to: 01)
						.stroke(style: StrokeStyle(lineWidth: 1))
						.frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
						.foregroundColor(.white)
					Image(systemName: "chevron.down.circle")
						.foregroundColor(Color.ui.accent.opacity(0.5))
						.font(.system(size: 15))
						.rotationEffect(showMenu ? .init(degrees: 180) : .zero)
				}
				.offset(x: -5, y: 28)
				.onTapGesture {
					withAnimation(.spring()) {
						self.showMenu = !self.showMenu
					}
				}
			}
			Menu()
				.scaleEffect(showMenu ? 1 : 0, anchor: .topTrailing)


			if album.zoomedAsset != nil {
				ZStack {
					Color.black.opacity(0.05).ignoresSafeArea(.all)
					bigImage

				}
			}
		}
	}

}

extension AlbumList {

	var bigImage: some View {

		Image(uiImage: album.getAsset(by: album.zoomedAsset).getFullImage())
			.resizable()
			.clipShape(RoundedRectangle(cornerRadius: 25.0))
			.scaledToFit()
			.overlay(
				RoundedRectangle(cornerRadius: 25)
					.stroke(Color.ui.backgound, lineWidth: 2)
			)
			.shadow(color: Color.ui.tint, radius: 10)
			.padding()
			.scaleEffect(scaleGrade)
			.onAppear(){
				withAnimation(.easeOut(duration: 1)) {
					scaleGrade = 1.0
				}
			}
			.onDisappear() {
				scaleGrade = 0.33
			}
			.onTapGesture {
				album.zoomedAsset = nil
			}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		AlbumList()
	}
}
