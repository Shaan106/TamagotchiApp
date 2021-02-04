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
    @Published var numButtonsPressed: Int = 0

    
    init(name: String) {
        self.name = name
        age = 0
        hunger = 0 //0 is full
        happyHearts = 5
        isIll = false
        timeIll = 0
        illProbability = 0
        weight = 5 //check max min etc
        discipline = 5 //10 is max
        defecated = false
        numButtonsPressed = 0
        isDead = false
    }
    
    func displayStats() -> String {
        if isDead == true {
            return"""
            Oops. \(self.name) is dead
            """
        } else if age >= 10{
            
            return"""
            \(self.name) died at the age of \(age).
            """
            
        } else {
            return"""
            name: \(name)
            age: \(age)
            happiness: \(happyHearts)
            hunger: \(hunger)
            weight: \(weight)
            is ill: \(isIll)           [prob \(illProbability), time \(timeIll)]
            defecated: \(defecated)    [time \(timeDefecated)]
            is dead: \(isDead)
            """
        }
        
    }
    
    func feedMeal() {
        weight = weight + 1
        hunger = hunger - 3
        
        setIllProbability(-3)
        numButtonsPressed = numButtonsPressed + 1
        nextTurnCheck()
    }
    
    func feedSnack() {
        happyHearts = happyHearts + 1
        weight = weight + 2
        
        setIllProbability(3)
        numButtonsPressed = numButtonsPressed + 1
        
        nextTurnCheck()
    }
    
    func removeDefecation() {
        if defecated == true {
            if timeDefecated > 2{
                setIllProbability(10)
                happyHearts = happyHearts - 1
                discipline = discipline - 2
            } else {
                happyHearts = happyHearts + 1
                discipline = discipline + 10
            }
            
        } else if defecated == false {
            setIllProbability(5)
            happyHearts = happyHearts - 2
            discipline = discipline - 2
        }
        
        defecated = false
        
        nextTurnCheck()
    }
    
    
    
    func giveMedicine() {
        if isIll == true {
            discipline = discipline + 10
            happyHearts = happyHearts + 2
            isIll = false
        } else {
            discipline = discipline - 5
            isIll = true
        }
    }
    
    func setIllProbability(_ illChange:Int) {
        illProbability = illProbability + illChange
        if illProbability == 0{
            timeIll = 0
        }
    }
    
    func playGame() {
        weight = weight - 1
        
        let roundsWon = 3 // between 3 and 5
        
        //add game mechanic
        
        if roundsWon >= 3 {
            happyHearts = happyHearts + 1
        }
        nextTurnCheck()
    }
    
    
    func nextTurnCheck() {
        
        if numButtonsPressed%3 == 0 {
            age =  age + 1
            
            if Int.random(in: 0...100) < illProbability && isIll == false {
                isIll = true
                timeIll = 0
            } else if isIll == true {
                timeIll = timeIll + 1
                if timeIll > 5 {
                    isDead = true
                }
            }
            
            if Int.random(in: 0...100) < 25 && defecated == false{
                defecated = true
                timeDefecated = 0
            } else if defecated == true {
                timeDefecated = timeDefecated + 1
                if timeDefecated > 3 && isIll == false{
                    isIll = true
                    timeIll = 0
                }
            }
            
        }
    }
    
}
