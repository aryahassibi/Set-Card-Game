//
//  SetGameViewModel.swift
//  Set
//
//  Created by Arya Hassibi on 7/27/22.
//

import SwiftUI

class ClassicSetGame: ObservableObject{
    typealias Card = SetGame<String, Color, Int, Double>.Card
    @Published private var model: SetGame<String, Color, Int, Double>
    init(){
         model = SetGame(
            shapes: ["diamond", "rectangle", "oval"],
            colors: [Color.red, Color.blue, Color.green],
            numbers: Array(1...3),
            shadings: [0, 0.25, 0.9])
    }
    
    var cards: Array<Card> {
        model.cards
    }
    func choose(_ card: Card){
        model.choose(card)
    }
    

}

//struct SetGameViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        SetGameViewModel()
//    }
//}
