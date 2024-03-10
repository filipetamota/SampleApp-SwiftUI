//
//  ImageDetailView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI
import SwiftData

struct ImageDetailView: View {
    @Environment(\.modelContext) private var context
    let photoId: String
    @ObservedObject var viewModel = ImageDetailViewModel()
    @State private var isFavorite = false
    @State private var showFavoriteAlert = false
    
    private var detailResponse: DetailResponseModel {
        viewModel.detailResponse
    }
    
    var body: some View {
        ZStack {
            LoadingIndicatorView()
                .show(viewModel.showLoadingIndicator)
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: detailResponse.imageUrls.regular)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    } placeholder: {
                        Image("img_placeholder", bundle: .main)
                    }

                    if let title = detailResponse.title {
                        Text(title)
                            .font(.headline)
                    }
                    if let description = detailResponse.description {
                        Text(description)
                            .font(.subheadline)
                    }
                    Text(buildTakenText(model: detailResponse))
                        .font(.footnote)
                    Spacer()
                }
            }
            .navigationTitle(NSLocalizedString("detail_title", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Image(systemName: $isFavorite.wrappedValue ? "bookmark.circle.fill" : "bookmark.circle")
                        .onTapGesture {
                            if let favorite = context.getFavoriteById(favId: detailResponse.photoId) {
                                context.delete(favorite)
                                isFavorite = false
                                showFavoriteAlert = true
                            } else {
                                let favorite = Favorite(photoId: detailResponse.photoId,
                                                        title: detailResponse.title,
                                                        desc: detailResponse.description,
                                                        width: detailResponse.width,
                                                        height: detailResponse.height,
                                                        likes: detailResponse.likes,
                                                        userName: detailResponse.user.name,
                                                        imageUrl: detailResponse.imageUrls.regular,
                                                        thumbUrl: detailResponse.imageUrls.thumb,
                                                        equipment: detailResponse.equipment?.model, location: detailResponse.location?.name)
                                context.insert(favorite)
                                isFavorite = true
                                showFavoriteAlert = true
                            }
                        }
                        .accessibilityIdentifier("FavoriteButton")
                }
            }
            .padding()
            .onAppear(perform: {
                viewModel.getImageDetail(photoId: photoId)
                isFavorite = context.checkIfIsFavorite(favId: photoId)
        })
            .alert(NSLocalizedString("success", comment: ""), isPresented: $showFavoriteAlert) {
            } message: {
                if isFavorite {
                    Text(NSLocalizedString("favorite_added", comment: ""))
                } else {
                    Text(NSLocalizedString("favorite_removed", comment: ""))
                }
            }
        }
    }
    
    private func buildTakenText(model: DetailResponseModel) -> String {
        var takenByText = String.localizedStringWithFormat(NSLocalizedString("taken_by", comment: ""), model.user.name.capitalized)
        if let location = model.location?.name {
            takenByText += String.localizedStringWithFormat(NSLocalizedString("taken_in", comment: ""), location)
        }
        if let equipmentModel = model.equipment?.model {
            takenByText += String.localizedStringWithFormat(NSLocalizedString("taken_with", comment: ""), equipmentModel)
        }

        takenByText += "."
        
        return takenByText
    }
    
}

#Preview {
    ImageDetailView(photoId: "1")
}
