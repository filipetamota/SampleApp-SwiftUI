//
//  HomeTableView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import Foundation
import SwiftUI

struct ImageTableView: View {
    @State private var searchResults = [
        SearchResult(photoId: "12345", thumbUrl: "https://i.fbcd.co/products/original/b8c6e8130e5374f4e5fdc903feaad917814bd58caef6a8d9a2c48f20b983bc33.jpg", title: "Title 1", author: "Author 1", likes: 5),
        SearchResult(photoId: "54321", thumbUrl: "https://getuikit.com/v2/docs/images/placeholder_200x100.svg", title: "Title 2", author: "Author 2", likes: 7),
        SearchResult(photoId: "56789", thumbUrl: "https://static1.1.sqspcdn.com/static/f/601505/26649964/1446646983280/OHI0084-WRI-ILovePictureBooks-500.jpg?token=NrbWgGKVs2B28Kmh%2FL8KMATV1%2FU%3D", title: "Title 3", author: "Author 3", likes: 123),
        SearchResult(photoId: "09876", thumbUrl: "https://ionicframework.com/docs/img/demos/thumbnail.svg", title: "Title 4", author: "Author 5", likes: 75)
    ]
    
    var body: some View {
        List {
            ForEach(searchResults) { result in
                ImageCellView(searchResult: result)
            }
        }
        .navigationTitle("Search")
    }
}

struct PlaylistTableView_Previews: PreviewProvider {
    static var previews: some View {
        ImageTableView()
    }
}
