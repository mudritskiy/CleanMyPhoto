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
