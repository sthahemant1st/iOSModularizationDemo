//
//  ItemListScreen.swift
//  MyLibrary
//
//  Created by Hemant Shrestha on 18/12/2024.
//


import SwiftUI

struct ItemListScreen: View {
    private let goToItemDetails: () -> Void
    
    init(goToItemDetails: @escaping () -> Void) {
        self.goToItemDetails = goToItemDetails
    }
    
    var body: some View {
        VStack {
            Text("Item List Screen")
            Button(
                "Go Item Details",
                action: goToItemDetails
            )
        }
    }
}

#Preview {
    ItemListScreen(goToItemDetails: {})
}