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

    var body: some View {

        ZStack {
//            Color.color1
//                .ignoresSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(album.sections, id: \.id) { section in
                        Section() {
                            SectionView(section: section)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumList()
    }
}
