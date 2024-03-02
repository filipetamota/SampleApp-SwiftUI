//
//  FavoriteTableView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 2/3/24.
//

import Foundation
import SwiftUI

struct FavoriteTableView: View {
    @Environment(\.modelContext) private var context
    @State var favorites: [Favorite] = []
    
    var body: some View {
        VStack {
            List {
                ForEach($favorites, id: \.self) { favorite in
                    NavigationLink(destination: ImageDetailView(photoId: favorite.photoId.wrappedValue)) {
                        HomeRowView(searchResult: favorite.wrappedValue.toSearchResult())
                    }

                }.onDelete(perform: { indexSet in
                    if let indexToDelete = indexSet.first {
                        context.delete(favorites[indexToDelete])
                    }
                })
            }.listStyle(.plain)
        }
        .navigationTitle("Favorites")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            favorites = context.getAllFavorites()
        })
    }
}

#Preview {
    FavoriteTableView()
}
