import SwiftUI

enum WhoDrinks: String, CaseIterable {
    case you = "You"
    case someoneyoupick = "Someone you pick"
    case personright = "Person on your right"
    case personleft = "Person on your left"
    case everyone = "Everyone"
    case noone = "No one"
    
    var symbol: String {
        switch self {
        case .you: return "👤"
        case .someoneyoupick: return "👆"
        case .personright: return "👉"
        case .personleft: return "👈"
        case .everyone: return "👥"
        case .noone: return "🚫"
        }
    }
}

enum HowMuch: String, CaseIterable {
    case sip = "Sip"
    case half = "Half your drink"
    case finish = "Finish your drink"
    case finishtwo = "Finish two drinks"
    case finishthree = "Finish 3 drinks"
    
    var symbol: String {
        switch self {
        case .sip: return "💧"
        case .half: return "🥤"
        case .finish: return "🍺"
        case .finishtwo: return "🍺🍺"
        case .finishthree: return "🍺🍺🍺"
        }
    }
    
    static var weightedCases: [HowMuch] {
        [.sip, .half, .finish, .finish, .finishtwo, .finishthree]
    }
}

struct DiceState {
    var whoDrinks: WhoDrinks
    var howMuch: HowMuch
    var isRolling: Bool = false
}