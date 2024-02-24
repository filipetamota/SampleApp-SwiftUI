//
//  ImageListModel.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 24/2/24.
//

import SwiftUI

struct SearchResult: Identifiable {
    let id = UUID()
    let photoId: String
    let thumbUrl: String
    let title: String
    let author: String
    let likes: Int
    
}
