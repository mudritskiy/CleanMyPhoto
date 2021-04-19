//
//  Menu.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 18.04.2021.
//

import SwiftUI

struct Menu: View {

	@EnvironmentObject var album: AlbumData
	@State var fontSize: CGFloat = 13

	var body: some View {

		GeometryReader{ geometry in

			ZStack(alignment: .topLeading) {
				RoundedRectangle(cornerRadius: 5, style: .continuous)
					.foregroundColor(Color.ui.backgound)
					.shadow(color: Color.ui.accent.opacity(0.3), radius: 2)
				VStack(alignment: .leading, spacing: 5) {
					HStack {
						Spacer()
						Text("Sections")
							.font(.system(size: fontSize + 1, weight: Font.Weight.light, design: Font.Design.rounded))
					}
					Divider()
					HStack {
						Text("by date")
							.font(.system(size: fontSize, weight: Font.Weight.thin, design: Font.Design.rounded))
							.onTapGesture {
								if album.sectionType != .date  {
									album.sectionType = .date
								}
							}
						Spacer()
						if album.sectionType == .date {
							Image(systemName: "checkmark")
								.foregroundColor(Color.ui.accent)
								.font(.system(size: fontSize - 2))
						}
					}
					HStack {
						Text("by size")
							.font(.system(size: fontSize, weight: Font.Weight.thin, design: Font.Design.rounded))
							.onTapGesture {
								if album.sectionType != .size {
									album.sectionType = .size
								}
							}
						Spacer()
						if album.sectionType == .size {
							Image(systemName: "checkmark")
								.foregroundColor(Color.ui.accent)
								.font(.system(size: fontSize - 2))
						}

					}
					Spacer()
					HStack {
						Spacer()
						Text("Sorting")
							.font(.system(size: fontSize + 1, weight: Font.Weight.light, design: Font.Design.rounded))
					}
					Divider()
					HStack {
						Text("ascendind")
							.font(.system(size: fontSize, weight: Font.Weight.thin, design: Font.Design.rounded))
							.onTapGesture {
								if album.sortDesc {
									album.sortDesc = false
								}
							}
						Spacer()
						if !album.sortDesc {
							Image(systemName: "checkmark")
								.foregroundColor(Color.ui.accent)
								.font(.system(size: fontSize - 2))
						}
					}
					HStack {
						Text("descending")
							.font(.system(size: fontSize, weight: Font.Weight.thin, design: Font.Design.rounded))
							.onTapGesture {
								if !album.sortDesc {
									album.sortDesc = true
								}
							}
						Spacer()
						if album.sortDesc {
							Image(systemName: "checkmark")
								.foregroundColor(Color.ui.accent)
								.font(.system(size: fontSize - 2))
						}

					}

				}
				.padding()

			}
		}
		.frame(width: 120, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
	}
}


//struct Menu_Previews: PreviewProvider {
//	static var previews: some View {
//		Menu()
//	}
//}
