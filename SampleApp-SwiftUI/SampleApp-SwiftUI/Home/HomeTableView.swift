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
        VStack {
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
            }.listStyle(.plain)
        }
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Image(systemName: "book")
                    .onTapGesture {
                        
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

struct HomeTableView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTableView()
    }
}
