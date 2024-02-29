//
//  ImageCellView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct HomeRowView: View {
    let searchResult: SearchResultModel
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: URL(string: searchResult.imageUrls.thumb)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
            } placeholder: {
                Image("img_placeholder", bundle: .main)
            }
            VStack(alignment: .leading) {
                Text(searchResult.title)
                    .font(.headline)
                Spacer()
                HStack(alignment: .bottom) {
                    Text("By \(searchResult.user.name)")
                        .font(.footnote)
                    Spacer()
                    Text("\(searchResult.likes) likes")
                        .font(.footnote)
                }
                
            }
            
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    HomeRowView(searchResult: SearchResultModel(photoId: "1", title: "Preview title", likes: 200, user: .init(name: "User Name"), imageUrls: .init(thumb: "")))
}
