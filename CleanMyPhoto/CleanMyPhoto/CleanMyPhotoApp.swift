//
//  CleanMyPhotoApp.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 02.03.2021.
//

import SwiftUI

@main
struct CleanMyPhotoApp: App {

    @StateObject var album = AlbumData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(album)
        }
    }
}
