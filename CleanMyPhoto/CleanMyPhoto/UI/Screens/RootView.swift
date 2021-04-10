//
//  RootView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 08.04.2021.
//

import SwiftUI

struct RootView: View {
    @State var selectedView: Int = 1
    var body: some View {
        TabView(selection: $selectedView) {
            AlbumList()
                .tabItem { Label("Selection", systemImage: "square.grid.2x2") }
                .tag(1)
            ClearView()
                .tabItem { Label("Clear", systemImage: "trash") }
                .tag(2)
            VStack {
                
            }
            .tabItem { Label("Mode", systemImage: "gearshape") }
            .tag(3)
        }
        .accentColor(Color.ui.accent)
    }
}


struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
