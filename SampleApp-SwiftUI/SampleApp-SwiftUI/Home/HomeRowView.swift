//
//  ImageCellView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct HomeRowView: View {
    let searchResult: SearchResult
    
    var body: some View {
        NavigationLink(destination: ImageDetailView(result: searchResult)) {
            HStack {
//                Image(searchResult.thumbUrl)
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 70, height: 70)
//                    .cornerRadius(5)
//                    .padding(.leading, 8)
                Text(searchResult.alt_description)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}

//struct HomeRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeRowView(searchResult: SearchResult(id: "1", photoId: "", thumbUrl: "", title: "Preview Title", author: "Preview Author", likes: 300))
//    }
//}
