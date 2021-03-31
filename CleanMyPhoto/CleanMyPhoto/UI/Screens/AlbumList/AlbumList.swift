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
    @State var selectedView: Int = 2
    @State var scaleGrade: CGFloat = 0.33

    var body: some View {

        TabView(selection: $selectedView) {
            ZStack(alignment: Alignment.center) {
                Color.color4.ignoresSafeArea(.all)
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
                if album.zoomedAsset != nil {
                    ZStack {
                        //                            Color.black.opacity(0.1).ignoresSafeArea(.all)
                        bigImage

                    }
                }
            }
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
        .accentColor(.color5)
    }
}

extension AlbumList {

    var bigImage: some View {

        //        GeometryReader { gr in
        //        ZStack {
        Image(uiImage: album.getAsset(by: album.zoomedAsset).getFullImage())
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 25.0))
            .scaledToFit()
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.color1, lineWidth: 2)
            )
            .shadow(color: .color5, radius: 10)
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

            //                .overlay(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            //                            .trim())
            //                .cornerRadius(25)
            .onTapGesture {
//    withAnimation(.easeIn(duration: 1)) {
                album.zoomedAsset = nil
//    }
            }
    }
    //RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
    //    .stroke(Color.blue, style: StrokeStyle())
    //        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumList()
    }
}
