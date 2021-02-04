//
//  TamagotchiAppTests.swift
//  TamagotchiAppTests
//
//  Created by Aasmaan Yadav on 25/01/21.
//

import XCTest
@testable import TamagotchiApp

class TamagotchiAppTests: XCTestCase {

    func testFeedMealReturnsUpdatedStats() {
        //arrange
        let testTam = Tamagotchi(name:"testTam")
        
        let prevWeight = testTam.weight
        let prevHunger = testTam.hunger
        let prevProbability = testTam.illProbability
            
        //act
        
        testTam.feedMeal()
        
        //assert
        
        XCTAssertEqual(prevWeight + 1, testTam.weight)
        XCTAssertEqual(prevHunger, testTam.hunger)
        XCTAssertEqual(prevProbability, testTam.illProbability)
    }
    
    func testFeedSnackReturnsUpdatedStats() {
        //arrange
        let testTam = Tamagotchi(name:"testTam")
        
        let prevWeight = testTam.weight
        let prevHappyHearts = testTam.happyHearts
        let prevProbability = testTam.illProbability
            
        //act
        
        testTam.feedSnack()
        
        //assert
        
        XCTAssertEqual(prevWeight + 2, testTam.weight)
        XCTAssertEqual(prevHappyHearts, testTam.happyHearts)
        XCTAssertEqual(prevProbability + 3, testTam.illProbability)
    }
    
    func testGiveMedicineWithIllFalseReturnsUpdatedStats() {
        //arrange
        let testTam = Tamagotchi(name:"testTam")
        
        testTam.isIll = false
        
        let prevHappyHearts = testTam.happyHearts
        let prevDiscipline = testTam.discipline
            
        //act
        
        testTam.giveMedicine()
        
        //assert
        
        XCTAssertEqual(prevHappyHearts, testTam.happyHearts)
        XCTAssertEqual(prevDiscipline - 5, testTam.discipline)
    }
    
    func testGiveMedicineWithIllTrueReturnsUpdatedStats() {
        //arrange
        let testTam = Tamagotchi(name:"testTam")
        
        testTam.isIll = true
        
        let prevHappyHearts = testTam.happyHearts
        let prevDiscipline = testTam.discipline
            
        //act
        
        testTam.giveMedicine()
        
        //assert
        
        XCTAssertEqual(prevHappyHearts, testTam.happyHearts)
        XCTAssertEqual(prevDiscipline + 10, testTam.discipline)
    }
    
    func testPlayGameReturnsUpdatedStats() {
        //arrange
        let testTam = Tamagotchi(name:"testTam")
        
        testTam.isIll = true
        
        let prevHappyHearts = testTam.happyHearts
        let prevWeight = testTam.weight
            
        //act
        
        testTam.playGame()
        
        //assert
        
        XCTAssertEqual(prevHappyHearts, testTam.happyHearts)
        XCTAssertEqual(prevWeight - 1, testTam.weight)
    }

}






