//
//  Settings.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 12.04.2021.
//

import SwiftUI

struct Settings: View {

	@EnvironmentObject var album: AlbumData

	var body: some View {
		VStack {
			Text("Sections by")
			HStack {
				Text("date")
				sectionTypeCheckBox(showCheckMark: album.sectionType == .date)
					.onTapGesture {
						album.sectionType = .date
					}
				Text("size")
				sectionTypeCheckBox(showCheckMark: album.sectionType == .size)
					.onTapGesture {
						album.sectionType = .size
					}

			}
			Text("Sort priority")
			HStack {
				Text("ascendind")
				sectionTypeCheckBox(showCheckMark: !album.sortDesc)
					.onTapGesture {
						album.sortDesc = false
					}
				Text("descending")
				sectionTypeCheckBox(showCheckMark: album.sortDesc)
					.onTapGesture {
						album.sortDesc = true
					}

			}
		}
	}
}

struct sectionTypeCheckBox: View {

	var showCheckMark: Bool = true

	var body: some View {
		ZStack {
			Circle()
				.frame(width: 20, height: 20)
				.foregroundColor(.blue)
				.overlay(
					Circle()
						.frame(width: 18, height: 28)
						.foregroundColor(.white)
				)
			if showCheckMark == true {
				Image(systemName: "checkmark")
					.foregroundColor(.blue)
					.font(.system(size: 9))
			}
		}
	}
}

struct Settings_Previews: PreviewProvider {
	static var previews: some View {
		Settings()
	}
}
