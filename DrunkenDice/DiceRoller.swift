import SwiftUI
import Foundation

class DiceRoller: ObservableObject {
    @Published var whoDrinks: WhoDrinks = .you
    @Published var howMuch: HowMuch = .sip
    @Published var isRolling: Bool = false
    
    private var rollTimer: Timer?
    private var animationTimer: Timer?
    
    func rollDice() {
        guard !isRolling else { return }
        
        isRolling = true
        
        let rollDuration = Double.random(in: 1.0...3.0)
        
        animationTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.whoDrinks = WhoDrinks.allCases.randomElement() ?? .you
            self.howMuch = HowMuch.weightedCases.randomElement() ?? .sip
        }
        
        rollTimer = Timer.scheduledTimer(withTimeInterval: rollDuration, repeats: false) { _ in
            self.stopRolling()
        }
    }
    
    private func stopRolling() {
        animationTimer?.invalidate()
        animationTimer = nil
        rollTimer?.invalidate()
        rollTimer = nil
        
        whoDrinks = WhoDrinks.allCases.randomElement() ?? .you
        howMuch = HowMuch.weightedCases.randomElement() ?? .sip
        
        withAnimation(.easeOut(duration: 0.5)) {
            isRolling = false
        }
    }
    
    deinit {
        animationTimer?.invalidate()
        rollTimer?.invalidate()
    }
}