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
            .navigationTitle(NSLocalizedString("search_title", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: FavoriteTableView()) {
                        Image(systemName: "book")
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery, placement: .automatic)
            .alert(NSLocalizedString("error", comment: ""), isPresented: $viewModel.showError) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            .overlay(Group {
                if viewModel.searchResults.isEmpty {
                    Text(NSLocalizedString("no_results", comment: ""))
                        .multilineTextAlignment(.center)
                        .accessibilityIdentifier("PlaceholderText")
                }
            })
        }
    }
}

#Preview {
    HomeTableView()
}
