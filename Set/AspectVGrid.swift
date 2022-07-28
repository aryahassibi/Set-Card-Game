//
//  AspectVGrid.swift
//  Set
//
//  Created by Arya Hassibi on 7/27/22.
//

import SwiftUI

struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable{
    var items: [Item]
    var aspectRatio: Double
    var content: (Item) -> ItemView
    init(items: [Item], aspectRatio: Double, content: @escaping (Item)-> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    var body: some View {
        GeometryReader{ geometry in
            VStack{
                let width: CGFloat = widthThatFits(
                    numberOfItems: items.count,
                    size: geometry.size,
                    aspectRatio: aspectRatio)
                LazyVGrid(columns: [ZeroSpacingAdaptiveGridItem(width)], spacing: 0){
                    ForEach(items){ item in
                        content(item).aspectRatio(aspectRatio,contentMode: .fit)
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    private func ZeroSpacingAdaptiveGridItem(_ width: CGFloat) -> GridItem{
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    private func minimumWidthCalculator(numberOfItems:Int, size: CGSize, aspectRatio: Double) -> CGFloat{
        var columnCount = 1
        var rowCount = numberOfItems
        let itemWidth = { size.width / CGFloat(columnCount) }
        let itemHeight = { itemWidth() * ( 1 / aspectRatio) }
        while CGFloat(rowCount) * itemHeight() > size.height{
            columnCount += 1
            rowCount = Int(ceil(Double(numberOfItems) / Double(columnCount)))
        }
        return floor(itemWidth())
    }
    private func widthThatFits(numberOfItems: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat{
        var columnCount = 1
        var rowCount = numberOfItems
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth * (1 / aspectRatio)
            if CGFloat(rowCount) * itemHeight < size.height{
                break
            }
            columnCount += 1
            rowCount = (numberOfItems + (columnCount - 1)) / columnCount
        } while columnCount < numberOfItems
        if columnCount > numberOfItems{
            columnCount = numberOfItems
        }
        return floor(size.width / CGFloat(columnCount))
    }
}

//struct AspectVGrid_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectVGrid()
//    }
//}
