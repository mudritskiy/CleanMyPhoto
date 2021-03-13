//
//  ContentView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import Photos
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        let album = AlbumData()
        
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(album.sections, id: \.id) { section in
                    Section() {
                        SectionView(album: album, section: section)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
