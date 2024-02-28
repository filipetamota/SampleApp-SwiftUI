//
//  ImageDetailView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct ImageDetailView: View {
    let result: SearchResult
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                VStack {
//                    Image(result.thumbUrl)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(maxWidth: .infinity, maxHeight: proxy.size.width)
//                        .cornerRadius(10)
//                        .padding()
                    Text(result.alt_description)
                        .font(.largeTitle)
                        .padding(.bottom, 10)
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis massa et eros volutpat posuere a vel nisl.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

//struct ImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageDetailView(result: SearchResult(id: "1", photoId: "123", thumbUrl: "", title: "Preview title", author: "Author title", likes: 123))
//    }
//}
