//
//  ContentView.swift
//  Set
//
//  Created by Arya Hassibi on 7/27/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game = ClassicSetGame()
    var body: some View {
        VStack{
            AspectVGrid(items: game.cards, aspectRatio: 2/3){ card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {game.choose(card)}
            }
        }.padding(.horizontal)
    }
}

struct CardView: View {
    var card: ClassicSetGame.Card
    var body: some View {
        ZStack{
            let rect = RoundedRectangle(cornerRadius: CGFloat(10))
            rect.foregroundColor(.white)
            if card.status == .selected{
                rect.foregroundColor(.blue).opacity(0.2)
            }
            rect.strokeBorder(lineWidth: CGFloat(4))
                .foregroundColor(Color.init(white: 0.4))
            symbolsOnCard
        }
        
    }
    
    private var symbolsOnCard: some View{
        VStack{
            ForEach(0..<card.number, id:\.self){ item in
                ZStack{
                    switch card.shape{
                    case "diamond":
                        modifySymbol(card.shading){ Diamond() }
                    case "rectangle":
                        modifySymbol(card.shading){ Rectangle() }
                    case "oval":
                        modifySymbol(card.shading){ Capsule() }
                    default:
                        Text("Undefined Shape")
                    }
                }
            }
            .padding(1.5)
            .aspectRatio(2, contentMode: .fit)
        }
        .foregroundColor(card.color)
        .padding()
    }
    private func modifySymbol<S:Shape>(_ shading: Double, shape: () -> S) -> some View{
        ZStack{
            shape().opacity(shading)
            shape().stroke(lineWidth: 5)
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
