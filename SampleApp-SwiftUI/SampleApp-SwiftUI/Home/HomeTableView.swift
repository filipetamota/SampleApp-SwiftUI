//
//  HomeTableView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import Foundation
import SwiftUI

struct HomeTableView: View {
    @ObservedObject var viewModel = SearchResultViewModel()
    
    var body: some View {
        ZStack {
            LoadingIndicatorView()
                .show(viewModel.showLoadingIndicator)
            List {
                ForEach(viewModel.searchResults, id: \.self) { searchResult in
                    NavigationLink(destination: ImageDetailView(photoId: searchResult.photoId)) {
                        HomeRowView(searchResult: searchResult)
                            .task {
                                if viewModel.shouldLoadMore(lastItem: searchResult) {
                                    viewModel.loadMore()
                                }
                            }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: FavoriteTableView()) {
                        Image(systemName: "book")
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery, placement: .automatic)
            .alert("Error", isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

#Preview {
    HomeTableView()
}
