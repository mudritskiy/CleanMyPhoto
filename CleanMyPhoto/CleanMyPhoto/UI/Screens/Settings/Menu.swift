//
//  Menu.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 18.04.2021.
//

import SwiftUI

struct Menu: View {

	@EnvironmentObject var album: AlbumData
	@State private var fontSize: CGFloat = 24
	@State private var checkmarkSize: CGFloat = 18

	var body: some View {

		GeometryReader{ geometry in

			ZStack(alignment: .topLeading) {
				RoundedRectangle(cornerRadius: 5, style: .continuous)
					.foregroundColor(Color.ui.backgound)
					.shadow(color: Color.ui.accent.opacity(0.3), radius: 2)
				VStack(alignment: .leading, spacing: 5) {
					menuSection(name: "Sections", options: [
									menuOption(name: "by date", value: .date),
									menuOption(name: "by size", value: .size)])

					menuSection(name: "Sorting", options: [
									menuOption(name: "ascendind", value: .ascendind),
									menuOption(name: "descending", value: .descending)])
				}
				.padding()
			}
		}
		.frame(width: fontSize * 8, height: fontSize * 6, alignment: .center)
	}

	func menuSection(name: String, options: [menuOption]) -> some View {
		VStack {
			HStack {
				Spacer()
				Text(name)
					.font(.system(size: fontSize, weight: Font.Weight.light, design: Font.Design.rounded))
			}
			Divider()
			ForEach(options, id: \.self) { option in
				HStack {
					Text(option.name)
						.font(.system(size: fontSize, weight: Font.Weight.thin, design: Font.Design.rounded))
					Spacer()
					if showCheckmark(option.value) {
						Image(systemName: "checkmark")
							.foregroundColor(Color.ui.accent)
							.font(.system(size: checkmarkSize))
					}
				}
				.contentShape(Rectangle())
				.onTapGesture {
					tapAction(option.value)
				}
			}
		}
	}

	func tapAction(_ type: menuOptionValue) -> Void {

		switch type {
		case .date:
			if album.sectionType != .date  {
				self.album.sectionType = .date
			}
		case .size:
			if self.album.sectionType != .size  {
				self.album.sectionType = .size
			}
		case .ascendind:
			if album.sortDesc  {
				self.album.sortDesc = false
			}
		case .descending:
			if !self.album.sortDesc  {
				self.album.sortDesc = true
			}
		}
	}

	func showCheckmark(_ type: menuOptionValue) -> Bool {
		switch type {
		case .date:
			return album.sectionType == .date
		case .size:
			return album.sectionType == .size
		case .ascendind:
			return !album.sortDesc
		case .descending:
			return album.sortDesc
		}
	}

	struct menuOption: Hashable {
		var name: String
		var value: menuOptionValue
	}

	enum menuOptionValue {
		case date
		case size
		case ascendind
		case descending
	}
}

//struct Menu_Previews: PreviewProvider {
//	static var previews: some View {
//		Menu()
//	}
//}
