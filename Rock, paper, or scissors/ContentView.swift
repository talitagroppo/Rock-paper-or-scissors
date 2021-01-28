//
//  ContentView.swift
//  Rock, paper, or scissors
//
//  Created by Talita Groppo on 27/01/2021.
//

import SwiftUI

struct ContentView: View {
    var movement = ["Rock", "Paper", "Scissors"]
        @State private var gameWin = false
        @State private var score = 0
        @State private var choice = "Rock"

        @State private var alert = false
        @State private var title = ""
        @State private var scoreRound = 0
        @State private var scoreGame = false

        var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.pink, Color(.clear)]), startPoint: .center, endPoint: .topLeading).edgesIgnoringSafeArea(.all)

                VStack {

                    VStack(spacing: 25) {
                        Text("Play the game".uppercased())
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.red)
                    .padding()

                    Spacer()
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            rockWasSelected()
                        }) {
                            Text("\(movement[0])")
                                .buttonDesign()
                        }
                        
                        Button(action: {
                            paperWasSelected()
                        }) {
                            Text("\(movement[1])")
                                .buttonDesign()
                        }
                       
                        Button(action: {
                            scissorsWasSelected()
                        }) {
                            Text("\(movement[2])")
                                .buttonDesign()
                        }
                    }
                    Spacer()

                    Text(scoreGame ? "Score \(score)" : "")
                        .font(.title)
                        .foregroundColor(.black)
                }
            }
            .alert(isPresented: $alert) {
                Alert(title: Text(scoreGame ? "GAME OVER!" : title), message: Text("Your result is \(score)"), dismissButton: .default(Text(scoreGame ? "Click for next game" : "Next round")){
                    nextRound()
                })
            }
        }

        func nextRound() {
            choice = movement[Int.random(in: 0...2)]
            gameWin = Bool.random()
            scoreRound += 1
            if scoreRound <= 10 {
                scoreGame = false
            } else {
                scoreGame = true
                scoreRound = 0
            }
        }

        func rockWasSelected() {
            if choice == movement[2] && gameWin || choice == movement[1] && !gameWin {
                score += 1
                title = "You Win!"
            } else if choice == movement[0] && gameWin || choice == movement[0] && !gameWin {
                score += 0
                title = "Tied!"
            } else {
                score -= 1
                title = "You loose!"
            }
            alert = true
        }

        func paperWasSelected() {
            if choice == movement[0] && gameWin || choice == movement[2] && !gameWin {
                score += 1
                title = "You Win!"
            } else if choice == movement[1] && gameWin || choice == movement[1] && !gameWin {
                score += 0
                title = "Tied!"
            } else {
                score -= 1
                title = "You loose!"
            }
            alert = true
        }

        func scissorsWasSelected() {
            if choice == movement[1] && gameWin || choice == movement[0] && !gameWin {
                score += 1
                title = "You Win"
            } else if choice == movement[2] && gameWin || choice == movement[2] && !gameWin {
                score += 0
                title = "Tired!"
            } else {
                score -= 1
                title = "You loose!"
            }
            alert = true
        }
    }

    struct ButtonDesign: ViewModifier {
        func body(content: Content) -> some View {
            content
                .frame(width: 120, height: 100, alignment: .center)
                .foregroundColor(.pink)
                .background(Color.white)
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .cornerRadius(2)
        }
    }

    extension View {
        func buttonDesign() -> some View {
            modifier(ButtonDesign())
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
