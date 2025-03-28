//
//  AspectVGrid.swift
//  Memoria
//
//  Created by Josue Contreras on 27/03/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemsWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0){
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio ,contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
    
    func gridItemsWidthThatFits(
       count: Int,
       size: CGSize,
       atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        print("cards", count, size.width, size.height, aspectRatio)

        repeat {
            let width = size.width / columnCount
            let heigth = width / aspectRatio
            print("heigth", heigth)

            let rowCount = (count / columnCount).rounded(.up)

            if rowCount * heigth < size.height {
                return (size.width / columnCount).rounded(.down)//width.rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}

