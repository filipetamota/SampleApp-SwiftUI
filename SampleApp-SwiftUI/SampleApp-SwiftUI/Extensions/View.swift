//
//  View.swift
//  SampleApp-SwiftUI
//
//  Created by Filipe Mota on 4/3/24.
//

import SwiftUI

extension View {
    @ViewBuilder func show(_ shouldShow: Bool) -> some View {
        switch shouldShow {
        case true: self
        case false: self.hidden()
        }
    }
}
