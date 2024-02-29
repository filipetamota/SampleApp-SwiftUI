//
//  ImageDetailView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct ImageDetailView: View {
    let photoId: String
    @ObservedObject var viewModel = ImageDetailViewModel()
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: viewModel.detailResponse.imageUrls.regular)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                } placeholder: {
                    Image("img_placeholder", bundle: .main)
                }

                if let title = viewModel.detailResponse.title {
                    Text(title)
                        .font(.headline)
                }
                if let description = viewModel.detailResponse.description {
                    Text(description)
                        .font(.subheadline)
                }
                Text(buildTakenText(model: viewModel.detailResponse))
                    .font(.footnote)
                Spacer()
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Image(systemName: "bookmark.circle")
                    .onTapGesture {
                        
                    }
            }
        }
        .padding()
        .onAppear(perform: {
            viewModel.getImageDetail(photoId: photoId)
        })
    }
    
    private func buildTakenText(model: DetailResponseModel) -> String {
        var takenByText = "Taken by \(model.user.name)"
        if let equipmentModel = model.equipment?.model {
            takenByText += " with \(equipmentModel)"
        }
        if let location = model.location?.name {
            takenByText += " in \(location)"
        }
        takenByText += "."
        
        return takenByText
    }
}

#Preview {
    ImageDetailView(photoId: "1")
}
