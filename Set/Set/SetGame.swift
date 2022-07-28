//
//  SetGame.swift
//  Set
//
//  Created by Arya Hassibi on 7/27/22.
//

import Foundation

struct SetGame<ShapeType, ColorType, NumberType, ShadingType>{
    private var cardDeck: Array<Card>
    private(set) var cards: Array<Card>
    private(set) var selectedCards = Array<Card>()

    init(shapes: [ShapeType], colors: [ColorType], numbers: [NumberType], shadings: [ShadingType]){
        cardDeck = []
        var cardIndex = 1
        for shape in shapes{
            for color in colors{
                for shading in shadings{
                    for number in numbers{
                        cardDeck.append(Card(shape: shape, color: color, number: number, shading: shading, id: cardIndex))
                        cardIndex += 1
                    }
                }
            }
        }
        cardDeck.shuffle()
        cards = Array(cardDeck[0...3])
        cardDeck = Array(cardDeck[12...])
    }
    
    
    mutating func choose(_ card: Card){
        for index in cards.indices{
            if cards[index].id == card.id && selectedCards.count < 3{
                cards[index].status = .selected
                selectedCards.append(cards[index])
            }
        }
        if selectedCards.count == 3{
            checkSelectedCards()
        }
    }
    
    func checkSelectedCards(){
        
    }
    struct Card: Identifiable{
        let shape: ShapeType
        let color: ColorType
        let number: NumberType
        let shading: ShadingType
        let id: Int
        var status = Status.neutral
    }
    enum Status{
        case neutral
        case selected
        case matched
        case misMatched
    }
}
