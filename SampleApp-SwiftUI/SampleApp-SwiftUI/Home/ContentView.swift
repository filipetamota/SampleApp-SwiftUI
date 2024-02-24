//
//  ContentView.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 22/2/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            ImageTableView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
