//
//  ContentView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import Photos
import SwiftUI

struct ContentView: View {
    
    @State var checkedAssets: Set<UUID> = []

    var body: some View {

        let album = AlbumData()

        ZStack {
            Color.color1
                .ignoresSafeArea(.all)
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                    ForEach(album.sections, id: \.id) { section in
                        Section() {
                            SectionView2(album: album, section: section, checkedAssets: $checkedAssets)
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
        ContentView()
    }
}
