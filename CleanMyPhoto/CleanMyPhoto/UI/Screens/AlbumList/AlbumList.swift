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
	@State private var showMenu: Bool = false
	@State private var showSummary: Bool = false

	var body: some View {

		let showMenuTapWithCondition = TapGesture()
			.onEnded { _ in
				if showMenu {
					showMenu = !showMenu
				}
			}

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

			GeometryReader { geometry in
				HStack {
					Spacer()
					ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
						Menu()
							.scaleEffect(showMenu ? 1 : 0, anchor: .topTrailing)
							.offset(x: -25, y: 25)
						settingsButton
					}
				}
			}
			.animation(.spring())

			GeometryReader { geometry in
				VStack {
					Spacer()

					HStack(alignment: .center, spacing: nil) {
						Spacer()
						Button(action: {
							withAnimation(Animation.easeIn(duration: 2).delay(2)) {
								showSummary = true }
						}, label: {
							Text("Clear")
								.font(.system(size: 25, weight: Font.Weight.medium, design: Font.Design.rounded))
						})
						.padding(.vertical, 5)
						.padding(.horizontal, 10)
						.background(Color.ui.tint)
						.cornerRadius(25)
						.shadow(color: Color.ui.accent.opacity(0.5), radius: 2, x: 1, y: 1)
						.offset(y: -10)
//						.animation(.easeIn)
//						.popover(isPresented: $showSummary) {
//							ClearView()
//						}
						Spacer()
					}
				}
			}

//			if showSummary {
//				ClearView( showSummary: $showSummary)
//					.transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)))
//			}

			if album.zoomedAsset != nil {
				ZStack {
					Color.black.opacity(0.05).ignoresSafeArea(.all)
					bigImage
				}
			}
		}
		.contentShape(Rectangle())
		.gesture(showMenuTapWithCondition)
		.navigate(to: ClearView( showSummary: $showSummary), when: $showSummary)
	}


	var settingsButton: some View {
		ZStack {
			let showMenuTap = TapGesture()
				.onEnded { _ in
					showMenu = !showMenu
				}
			Group {
				Circle()
					.trim(from: 0.0, to: 1)
					//				.stroke(style: StrokeStyle(lineWidth: 1))
					.frame(width: 40, height: 40, alignment: .center)
					.foregroundColor(.white)
				Image(systemName: "plus.circle")
					.foregroundColor(Color.ui.accent.opacity(0.8))
					.font(.system(size: 40))
					.rotationEffect(.init(degrees: showMenu ? 135 : 0))
			}
			.contentShape(Rectangle())
			.gesture(showMenuTap)
		}
	}

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

//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//		AlbumList()
//	}
//}
