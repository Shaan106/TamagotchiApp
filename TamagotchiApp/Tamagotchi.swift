//
//  Tamagotchi.swift
//  TamagotchiApp
//
//  Created by Aasmaan Yadav on 25/01/21.
//

import Foundation

class Tamagotchi: ObservableObject {
    
    @Published var name: String
    @Published var age: Int = 0
    @Published var hunger: Int = 0 {
        didSet {
            if hunger > 5 {
                hunger = 5
            }else if hunger < 0 {
                hunger = 0
            }
        }
    }
    
    @Published var happyHearts: Int = 5 {
        didSet {
            if happyHearts > 5 {
                happyHearts = 5
            }else if happyHearts < 0 {
                happyHearts = 0
            }
        }
    }
    
    @Published var isIll: Bool = false
    @Published var timeIll: Int = 0
    @Published var illProbability: Int = 0 {
        didSet {
            if illProbability < 0 {
                illProbability = 0
            }else if illProbability > 75 {
                illProbability = 75
            }
        }
    }
    
    @Published var weight: Int = 3{
        didSet {
            if weight < 1 {
                weight = 1 
            }
        }
    }
    
    //removed showing ddiscipline as it made everything too complicatedd
    @Published var discipline: Int = 5 //10 is max
    @Published var defecated: Bool = false
    @Published var timeDefecated: Int = 0
    @Published var isDead: Bool = false
    @Published var deathReason: String = "error"

    
    init(name: String) {
        self.name = name
        age = 0
        hunger = 0 //0 is full
        happyHearts = 5
        isIll = false
        timeIll = 0
        illProbability = 30
        weight = 5 //check max min etc
        discipline = 5 //10 is max
        defecated = false
        isDead = false
    }
    
    //these are here because for some reason I couldn't string interpolate booleans in contentView
    func displayHappiness() -> String {
        var returnString = ""
        for _ in 1...happyHearts {
            returnString = returnString + "❤️"
        }
        return returnString
    }
    
    func displayHunger() -> String {
        var returnString = ""
        if hunger == 0 {
            return returnString
        } else {
            for _ in 1...hunger {
                returnString = returnString + "🍽️"
            }
            return returnString
        }
    }
    
    func displayWeight() -> String {
        var returnString = ""
        for _ in 1...weight {
            returnString = returnString + "🍰"
        }
        return returnString
    }
    
    func displayIllness() -> String {
        if isIll == true {
            return "🤢 [prob \(illProbability), time \(timeIll)]"
        }else{
            return "🙂 [prob \(illProbability), time \(timeIll)]"
        }
    }
    
    func displayDefecation() -> String {
        if defecated == true {
            return "💩 [time \(timeDefecated)]"
        }else{
            return "🙃 [time \(timeDefecated)]"
        }
    }
    
    func displayDeadness() -> String {
        if isDead == false {
            return "⭐"
        }else{
            return "☠️"
        }
    }
    
    func feedMeal() {
        weight = weight + 1
        hunger = hunger - 2
        
        setIllProbability(-5)
    }
    
    func feedSnack() {
        happyHearts = happyHearts + 1
        weight = weight + 2
        
        setIllProbability(5)
    }
    
    func removeDefecation() {
//        if defecated == true {
//            if timeDefecated > 2{
//                setIllProbability(10)
//                happyHearts = happyHearts - 1
//                discipline = discipline - 2
//            } else {
//                happyHearts = happyHearts + 1
//                discipline = discipline + 10
//            }
//
//        } else if defecated == false {
//            setIllProbability(5)
//            happyHearts = happyHearts - 2
//            discipline = discipline - 2
//        }
        if defecated == true {
            defecated = false
            happyHearts += 1
            hunger += 1
        } else {
            setIllProbability(10)
            happyHearts -= 1
        }
        
    }
    
    
    
    func giveMedicine() {
        if isIll == true {
            isIll = false
            happyHearts += 1
            hunger += 2
            setIllProbability(-25)
        } else {
            setIllProbability(15)
            happyHearts -= 1
            defecated = true
        }
    }
    
    func setIllProbability(_ illChange:Int) {
        illProbability = illProbability + illChange
        if illProbability == 0{
            timeIll = 0
        }
    }
    
    func playGame() {
//        weight = weight - 1
//
//        let roundsWon = 3 // between 3 and 5
//
//        //add game mechanic
//
//        if roundsWon >= 3 {
//            happyHearts = happyHearts + 1
//        }
        weight -= 1
    }
    
    
    func nextTurnCheck() {

        if Int.random(in: 0...100) < illProbability && isIll == false {
            isIll = true
            timeIll = 0
        } else if isIll == true {
            timeIll = timeIll + 1
            if timeIll > 3 {
                isDead = true
                deathReason = "You neglected \(name) and \(name) became too ill!"
            }
        } else if isIll == false {
            timeIll = 0
        }
        
        
        if Int.random(in: 0...100) < 25 && defecated == false{
            defecated = true
            timeDefecated = 0
        } else if defecated == true {
            timeDefecated = timeDefecated + 1
            if timeDefecated > 2 && isIll == false{
                isIll = true
                timeIll = 0
            }
        } else if defecated == false {
            timeDefecated = 0
        }
        
        //change per year
        hunger += 3
        happyHearts -= 1
        
        if weight >= 15 {
            isDead = true
            deathReason = "You neglected \(name) and \(name) became too overweight!"
        }else if weight >= 8 {
            setIllProbability(10)
        }
        
        if hunger == 10 {
            isDead = true
            deathReason = "You neglected \(name) and \(name) starved to death!"
        }else if hunger >= 5 {
            setIllProbability(5)
        }
                
    }
}
