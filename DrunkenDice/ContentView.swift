//
//  ContentView.swift
//  DrunkenDice
//
//  Created by José Duarte on 28/07/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var diceRoller = DiceRoller()
    
    var body: some View {
        VStack(spacing: 40) {
            HStack(spacing: 30) {
                VStack(spacing: 16) {
                    Text("Who Drinks")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    WhoDrinksDice(
                        whoDrinks: diceRoller.whoDrinks,
                        isRolling: diceRoller.isWhoRolling,
                        rotationSpeed: diceRoller.whoRotationSpeed
                    )
                }
                
                VStack(spacing: 16) {
                    Text("How Much")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    HowMuchDice(
                        howMuch: diceRoller.howMuch,
                        isRolling: diceRoller.isHowMuchRolling,
                        rotationSpeed: diceRoller.howMuchRotationSpeed
                    )
                }
            }
            
            Button(action: {
                diceRoller.rollDice()
            }) {
                Text("ROLL")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(diceRoller.isRolling ? Color.gray : Color.blue)
                    )
            }
            .disabled(diceRoller.isRolling)
            .scaleEffect(diceRoller.isRolling ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: diceRoller.isRolling)
            
        }
        .padding()
        .background(Color(.systemBackground))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    ContentView()
}
