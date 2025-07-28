# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

DrunkenDice is an iOS drinking game app built with SwiftUI. The app features two dice that determine drinking rules: one die shows "who drinks" and another shows "how much to drink". The game includes animated rolling with random durations between 1-3 seconds.

## Build and Development Commands

Since this is an Xcode project, use Xcode for building and running:
- Open `DrunkenDice.xcodeproj` in Xcode
- Build: `⌘+B` in Xcode or `xcodebuild -project DrunkenDice.xcodeproj -scheme DrunkenDice build`
- Run: `⌘+R` in Xcode or use the iOS Simulator
- Target: iPhone (iOS 18.5+), supports both iPhone and iPad

## Architecture

The app follows a clean SwiftUI architecture with separation of concerns:

### Core Components
- **DiceModels.swift**: Contains game logic enums (`WhoDrinks`, `HowMuch`) with associated symbols and weighted distributions. `HowMuch.weightedCases` ensures "finish your drink" appears twice as often per game requirements.

- **DiceView.swift**: Reusable SwiftUI components for rendering dice as rounded rectangles. Includes base `DiceView` and specialized `WhoDrinksDice`/`HowMuchDice` wrappers.

- **DiceRoller.swift**: ObservableObject that manages game state and rolling animations. Uses Timer-based animation cycling through random values before settling on final results.

- **ContentView.swift**: Main game interface combining dice views with roll button. Handles UI state and user interactions.

### Key Design Patterns
- **MVVM**: DiceRoller acts as ViewModel, Views are pure UI, Models contain game logic
- **Observable Pattern**: Uses `@StateObject` and `@Published` for reactive UI updates
- **Animation State Management**: Rolling state controlled through boolean flags with Timer coordination
- **Weighted Random Selection**: `HowMuch.weightedCases` implements game rule requiring "finish your drink" to have 2 faces

### Game Logic
The dice use specific distributions:
- Who drinks: 6 equal options (you, someone you pick, left/right person, everyone, no one)
- How much: 6 weighted options with "finish your drink" appearing twice (sip, half, finish, finish, two drinks, three drinks)

Rolling animation cycles through random values for 1-3 seconds before landing on final results.