//
//  Favorite.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 2/3/24.
//

import Foundation
import SwiftData

@Model
class Favorite {
    @Attribute(.unique) var photoId: String
    var title: String?
    var desc: String?
    var width: Int
    var height: Int
    let likes: Int
    let userName: String
    let imageUrl: String
    let thumbUrl: String
    var equipment: String?
    var location: String?
    
    init(photoId: String, title: String? = nil, desc: String? = nil, width: Int, height: Int, likes: Int, userName: String, imageUrl: String, thumbUrl: String, equipment: String? = nil, location: String? = nil) {
        self.photoId = photoId
        self.title = title
        self.desc = desc
        self.width = width
        self.height = height
        self.likes = likes
        self.userName = userName
        self.imageUrl = imageUrl
        self.thumbUrl = thumbUrl
        self.equipment = equipment
        self.location = location
    }
}

extension Favorite{
    static var preview: Favorite {
        Favorite(photoId: "abc123",
                 title: "Preview title",
                 desc: "Preview description",
                 width: 500,
                 height: 500,
                 likes: 200,
                 userName: "Preview Author",
                 imageUrl: "",
                 thumbUrl: "",
                 equipment: "Nikon D50",
                 location: "Barcelona, Spain")
    }
    
    func toSearchResult() -> SearchResultModel {
        return SearchResultModel(photoId: photoId, title: title, likes: likes, user: SearchResultModel.User(name: userName), imageUrls: SearchResultModel.ImageUrl(thumb: thumbUrl))
    }
}
