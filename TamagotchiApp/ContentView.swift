//
//  ContentView.swift
//  TamagotchiApp
//
//  Created by Aasmaan Yadav on 25/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var userTamagotchi = Tamagotchi(name: "Ihctogamat")

    @State private var timePassed = 0
    @State private var isIllString = "false"
    @State private var showingAlert = true
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        
        
        VStack {
            
//            Button("Show Alert") {
//                        self.showingAlert = true
//                    }
//                    .alert(isPresented: $showingAlert) {
//                        Alert(title: Text("Hello SwiftUI!"), message: Text("This is some detail message"), dismissButton: .default(Text("OK")))
//                    }
//
                Spacer()
            VStack {
                Divider()
                Text(userTamagotchi.name)
                Divider()
                Form {
                    Text("Age: \(userTamagotchi.age)")
                        .onReceive(timer, perform: { _ in
                            if userTamagotchi.age < 100 {
                                self.timePassed += 1
                                if timePassed % 10 == 0 {
                                    userTamagotchi.age += 1
                                    
                                    userTamagotchi.nextTurnCheck()
                                }
                            }
                        })
                    Text("Happiness: \(userTamagotchi.displayHappiness())")
                    Text("Hunger: \(userTamagotchi.displayHunger())")
                    Text("Weight: \(userTamagotchi.displayWeight())")
                    Text("Is ill: \(userTamagotchi.displayIllness())")
                    Text("Defecated: \(userTamagotchi.displayDefecation())")
                    Text("Is dead: \(userTamagotchi.displayDeadness())")
                        .alert(isPresented: $userTamagotchi.isDead) {
                            Alert(title: Text("Unfortunately \(userTamagotchi.name) has died"), message: Text("Reason: \(userTamagotchi.deathReason)"), dismissButton: .default(Text("End Game")))
                        }
                }
            }
                
            
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 30) {
                
                
                
                HStack(alignment: .center, spacing: 30) {
                    Button("Feed Meal", action: {
                                            userTamagotchi.feedMeal()
                                        })
                    .padding(10)
                    .background(Color.purple)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    
                    Button("Feed Snack", action: {
                                            userTamagotchi.feedSnack()
                                        })
                    .padding(10)
                    .background(Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                }
                
                HStack(alignment: .center, spacing: 30) {
                    Button("Play Game", action: {
                                            userTamagotchi.playGame()
                                        })
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                }
                
                HStack(alignment: .center, spacing: 30) {
                    Button("Remove poop", action: {
                                            userTamagotchi.removeDefecation()
                                        })
                    .padding(10)
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    
                    Button("Give medicine", action: {
                                            userTamagotchi.giveMedicine()
                                        })
                    .padding(10)
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                }
            }
        
            Spacer()
                
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
