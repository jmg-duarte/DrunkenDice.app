import SwiftUI

struct DiceView: View {
    let value: String
    let symbol: String
    let isRolling: Bool
    let size: CGFloat = 120

    @State private var rotationAngle: Double = 0

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
                .rotation3DEffect(
                    .degrees(rotationAngle),
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.5
                )
                .opacity(isRolling ? (sin(rotationAngle * .pi / 180) < 0 ? 0.3 : 1.0) : 1.0)
            .onChange(of: isRolling) { _, newValue in
                if newValue {
                    withAnimation(.linear(duration: 0.1).repeatForever(autoreverses: false)) {
                        rotationAngle = 3600 // 10 full rotations
                    }
                } else {
                    withAnimation(.easeOut(duration: 0.5)) {
                        rotationAngle = 0
                    }
                }
            }
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
