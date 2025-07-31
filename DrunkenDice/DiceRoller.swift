import SwiftUI
import Foundation

class DiceRoller: ObservableObject {
    @Published var whoDrinks: WhoDrinks = .you
    @Published var howMuch: HowMuch = .sip
    @Published var isWhoRolling: Bool = false
    @Published var isHowMuchRolling: Bool = false
    @Published var whoRotationSpeed: Double = 0.4
    @Published var howMuchRotationSpeed: Double = 0.6
    
    var isRolling: Bool {
        isWhoRolling || isHowMuchRolling
    }
    
    private var whoTimer: Timer?
    private var howMuchTimer: Timer?
    private var whoAnimationTimer: Timer?
    private var howMuchAnimationTimer: Timer?
    
    func rollDice() {
        guard !isRolling else { return }
        
        // Generate random rotation speeds for each die
        whoRotationSpeed = Double.random(in: 0.2...0.6)
        howMuchRotationSpeed = Double.random(in: 0.2...0.6)
        
        isWhoRolling = true
        isHowMuchRolling = true
        
        // Random durations between 1-3 seconds, but ensure they're within 2 seconds of each other
        let baseDuration = Double.random(in: 1.0...2.0)
        let whoDuration = baseDuration + Double.random(in: 0.0...1.0)
        let howMuchDuration = baseDuration + Double.random(in: 0.0...1.0)
        
        // Start animation timers with different speeds
        whoAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.08, repeats: true) { _ in
            self.whoDrinks = WhoDrinks.allCases.randomElement() ?? .you
        }
        
        howMuchAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.12, repeats: true) { _ in
            self.howMuch = HowMuch.weightedCases.randomElement() ?? .sip
        }
        
        // Stop each die at different times
        whoTimer = Timer.scheduledTimer(withTimeInterval: whoDuration, repeats: false) { _ in
            self.stopWhoDice()
        }
        
        howMuchTimer = Timer.scheduledTimer(withTimeInterval: howMuchDuration, repeats: false) { _ in
            self.stopHowMuchDice()
        }
    }
    
    private func stopWhoDice() {
        whoAnimationTimer?.invalidate()
        whoAnimationTimer = nil
        whoTimer?.invalidate()
        whoTimer = nil
        
        whoDrinks = WhoDrinks.allCases.randomElement() ?? .you
        
        withAnimation(.easeOut(duration: 0.8)) {
            isWhoRolling = false
        }
    }
    
    private func stopHowMuchDice() {
        howMuchAnimationTimer?.invalidate()
        howMuchAnimationTimer = nil
        howMuchTimer?.invalidate()
        howMuchTimer = nil
        
        howMuch = HowMuch.weightedCases.randomElement() ?? .sip
        
        withAnimation(.easeOut(duration: 0.8)) {
            isHowMuchRolling = false
        }
    }
    
    deinit {
        whoAnimationTimer?.invalidate()
        howMuchAnimationTimer?.invalidate()
        whoTimer?.invalidate()
        howMuchTimer?.invalidate()
    }
}