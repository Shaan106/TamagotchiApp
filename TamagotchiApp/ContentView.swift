//
//  ContentView.swift
//  TamagotchiApp
//
//  Created by Aasmaan Yadav on 25/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var userTamagotchi = Tamagotchi(name: "NAME_GOES_HERE")
    
    var body: some View {
        
        VStack {
            Form {
                
                Text(userTamagotchi.displayStats())
                    .padding()
                
                Button("Feed Meal", action: {
                                        userTamagotchi.feedMeal()
                                    })
                Button("Feed Snack", action: {
                                        userTamagotchi.feedSnack()
                                    })
                Button("Play Game (placeholder)", action: {
                                        userTamagotchi.playGame()
                                    })
                Button("Remove poop", action: {
                                        userTamagotchi.removeDefecation()
                                    })
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
