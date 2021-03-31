//
//  ClearView.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 28.03.2021.
//

import SwiftUI

struct ClearView: View {

    @EnvironmentObject var album: AlbumData
    @State var zeroState: CGFloat = 0

    var body: some View {

        VStack {
            VStack {
                HStack {
                    Text("Photos")
                    Spacer()
                    Text("\(album.assetsCount.checked)")
                    Text(" of ")
                    Text("\(album.assetsCount.all)")
                }
                GeometryReader { geometry in
//                    VStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(.black)
                            .frame(width: geometry.size.width * album.assetsCount.percentage * zeroState, alignment: .leading)
                            .animation(Animation.easeIn(duration: 2).delay(1))
//                    }
                }
                .frame(height: 10, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            }
            .padding()
            .onAppear() {
//                withAnimation(.easeIn(duration: 1)) {
                    zeroState = 1

//                }
            }
            .onDisappear() {
                zeroState = 0
            }
//            .animation(.easeInOut)

        }
//        Text("\(album.assetsCount.checked) / \(album.assetsCount.all)")
//        Text("\(album.sizeSum.checked.readableSize.digits)")
//        Text("\(album.sizeSum.checked.readableSize.chars)")
//        Text("\(album.sizeSum.checked.readableSize) / \(album.sizeSum.all.readableSize)")
        //            Text("\(album.sizeSum.checked.readableSize) / \(album.sizeSum.all.readableSize)")
        //            Text("\(album.sizeSum.checked.readableSize) / \(album.sizeSum.all.readableSize)")
    }
}


struct ClearView_Previews: PreviewProvider {
    static var previews: some View {
        ClearView()
            .environmentObject(AlbumData())
    }
}
