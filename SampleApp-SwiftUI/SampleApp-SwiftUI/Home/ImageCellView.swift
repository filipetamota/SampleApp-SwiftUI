//
//  ImageCellView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct ImageCellView: View {
    let searchResult: SearchResult
    
    var body: some View {
        NavigationLink(destination: ImageDetailView(result: searchResult)) {
            HStack {
                Image(searchResult.thumbUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .cornerRadius(5)
                    .padding(.leading, 8)
                Text(searchResult.title)
                    .font(.headline)
                    .lineLimit(1)
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
}

struct ImageCellView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCellView(searchResult: SearchResult(photoId: "", thumbUrl: "", title: "Preview Title", author: "Preview Author", likes: 300))
    }
}
