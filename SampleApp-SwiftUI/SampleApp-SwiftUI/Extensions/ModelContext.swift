//
//  ModelContext.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 2/3/24.
//

import Foundation
import SwiftData

extension ModelContext {
    func getAllFavorites() -> [Favorite] {
        var descriptor = FetchDescriptor<Favorite>()
        do {
            return try fetch(descriptor)
        } catch {
            return []
        }
    }
    
    func getFavoriteById(favId: String) -> Favorite? {
        let predicate = #Predicate<Favorite> { object in
            object.favoriteId == favId
        }
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        do {
            let results = try fetch(descriptor)
            
            return results.first
        } catch {
            return nil
        }
    }
    
    func checkIfIsFavorite(favId: String) -> Bool {
        return getFavoriteById(favId: favId) != nil
    }
}
