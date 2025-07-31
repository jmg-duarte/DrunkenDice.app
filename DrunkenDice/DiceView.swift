import SwiftUI

struct DiceView: View {
    let value: String
    let symbol: String
    let isRolling: Bool
    let rotationSpeed: Double
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
                    withAnimation(.linear(duration: rotationSpeed).repeatForever(autoreverses: false)) {
                        rotationAngle = 720
                    }
                } else {
                    withAnimation(.easeOut(duration: 1.0)) {
                        rotationAngle = 0
                    }
                }
            }
    }
}

struct WhoDrinksDice: View {
    let whoDrinks: WhoDrinks
    let isRolling: Bool
    let rotationSpeed: Double

    var body: some View {
        DiceView(
            value: whoDrinks.rawValue,
            symbol: whoDrinks.symbol,
            isRolling: isRolling,
            rotationSpeed: rotationSpeed
        )
    }
}

struct HowMuchDice: View {
    let howMuch: HowMuch
    let isRolling: Bool
    let rotationSpeed: Double

    var body: some View {
        DiceView(
            value: howMuch.rawValue,
            symbol: howMuch.symbol,
            isRolling: isRolling,
            rotationSpeed: rotationSpeed
        )
    }
}
