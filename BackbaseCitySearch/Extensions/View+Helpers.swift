//
//  View+Helpers.swift
//  BackbaseCitySearch
//
//  Created by Amr Hesham on 06/06/2022.
//

import SwiftUI

extension View {
    /// - Parameter isHidden: A Boolean value that indicates whether to hide the View.
    /// - Returns: A view that is hidden or not.
    func isHidden(_ isHidden: Bool) -> Self? {
        isHidden ? nil : self
    }
}
