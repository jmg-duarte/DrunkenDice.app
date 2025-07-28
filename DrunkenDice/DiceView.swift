import SwiftUI

struct DiceView: View {
    let value: String
    let symbol: String
    let isRolling: Bool
    let size: CGFloat = 120
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .stroke(Color.black, lineWidth: 2)
            .frame(width: size, height: size)
            .overlay(
                VStack(spacing: 8) {
                    Text(symbol)
                        .font(.system(size: 28))
                    Text(value)
                        .font(.system(size: 12, weight: .medium))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .padding(8)
            )
            .rotationEffect(.degrees(isRolling ? 360 : 0))
            .animation(
                isRolling ? 
                    .linear(duration: 0.1).repeatForever(autoreverses: false) : 
                    .easeOut(duration: 0.5),
                value: isRolling
            )
    }
}

struct WhoDrinksDice: View {
    let whoDrinks: WhoDrinks
    let isRolling: Bool
    
    var body: some View {
        DiceView(
            value: whoDrinks.rawValue,
            symbol: whoDrinks.symbol,
            isRolling: isRolling
        )
    }
}

struct HowMuchDice: View {
    let howMuch: HowMuch
    let isRolling: Bool
    
    var body: some View {
        DiceView(
            value: howMuch.rawValue,
            symbol: howMuch.symbol,
            isRolling: isRolling
        )
    }
}