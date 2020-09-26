//
//  ViewController.swift
//  app2_rockehad_charles
//
//  Created by Charles Rockhead on 9/13/20.
//  Copyright © 2020 Charles Rockhead. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //links buttons and labels to view controller
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var p2_scoreboard: UILabel!
    @IBOutlet weak var p1_scoreboard: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet var buttons: [UIButton]! //collection of the tile buttons
    
    
    //model stuff
    var gameRunning = true
    
    
    //acc for each button
    var tileValue = [0,0,0,0,0,0,0,0,0]
    
    //scores for each player - property observers allow it to respond in real time
    var scoreOne = 0 {
        didSet {
            p1_scoreboard.text = "Player 1 Score: \(scoreOne)"
        }
    }
    
    var scoreTwo = 0 {
        didSet {
            p2_scoreboard.text = "Player 2 Score: \(scoreTwo)"
        }
    }
    
    
    //keep track of whose player turn
    var pOneTurn = true
    
    //the various winning combinations
    let winComb = [[0, 1, 2],
                   [3, 4, 5],
                   [6, 7, 8],
                   [0, 3, 6],
                   [1, 4, 7],
                   [2, 5, 8],
                   [2, 4, 6],
                   [0, 4, 8]]
    
    
    /**
     ***************************
     MANAGING TITLES/ MOVE BUTTONS
     ***************************
     */
    //the different types of labels we have
    //enum TileState {
   //     case x, o, blank
    //}
    
    /**
     ***************************
     MANAGING GAME STATES
     ***************************
     */

    //the various game states we have
    //enum GameState {
   //     case playing, win, lose, draw
   //}
    
    //setting the dynamics of these states
    
    
    //function which runs when we just set up the game
    override func viewDidLoad() {
        super.viewDidLoad()
        // set up the original states of the board
        turnLabel.text = "Player 1's Turn"
        clearButton.setTitle("Clear", for: .normal)
        p1_scoreboard.text = "Player 1 Score: \(scoreOne)"
        p2_scoreboard.text = "Player 2 Score: \(scoreTwo)"
        gameName.text = "Tic Tac Toe"
        
        for button in buttons {
            button.tintColor = .systemBlue
        }
    }

    @IBAction func clear(_ sender: Any) {
        //rest images to blank
        for button in buttons {
            button.setImage(UIImage(named: "mark-none"), for: .normal)
            button.tintColor = .systemBlue
        }
        
        //makes clear button blue
        clearButton.tintColor = .systemBlue
        
        //reset turn label
        turnLabel.textColor = UIColor.black
        turnLabel.text = "Player 1's Turn"
        
        //allow game to be run again
        gameRunning = true
        
        //make pOne's turn
        pOneTurn = true
        
        //reset tile values to 0
        for i in 0...8 {
            tileValue[i] = 0
        }
        print(tileValue)
  
    }
    

    
    @IBAction func playerMove(_ sender: UIButton) {
        
        if (tileValue[sender.tag - 1] == 0 ){ //allows only one piece to be placed
            
            tileValue[sender.tag - 1] = pOneTurn ? 1 : 2
           // print(tileValue[sender.tag])
            if (pOneTurn) {
                sender.setImage(UIImage(named: "mark-x.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            } else {
               sender.setImage(UIImage(named: "mark-o.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
            }
            
            //alternates players
            pOneTurn = !pOneTurn
            
        }
        
        /*
         GAME WIN
         check if game has been won
         */
        for comb in winComb {
            if ((tileValue[comb[0]] != 0) &&
                (tileValue[comb[0]] == tileValue[comb[1]]) &&
                (tileValue[comb[1] ] == tileValue[comb[2]])) {
                gameRunning = false
                
                //~check who won~
                //cross won
                if (tileValue[comb[0]] == 1) {
                    print("X -> WON")
                    
                    //change winner text
                    turnLabel.textColor = UIColor.green
                    turnLabel.text = "Player 1 Wins!"
                    
                    //update player score
                    scoreOne += 1
                    
                    //this way doesnt rlly work
                    /*
                    for i in comb {
                        buttons[i].tintColor = .systemYellow
                    }
                    */
                    
                    
                    var b1 = self.view.viewWithTag(comb[0] + 1)
                    b1?.tintColor = .systemYellow
                    var b2 = self.view.viewWithTag(comb[1] + 1)
                    b2?.tintColor = .systemYellow
                    var b3 = self.view.viewWithTag(comb[2] + 1)
                    b3?.tintColor = .systemYellow
                     
                    
                } else if (tileValue[comb[0]] == 2) {
                    print("O -> WON")
                    
                    //change winner text
                    turnLabel.textColor = UIColor.green
                    turnLabel.text = "Player 2 Wins!"
                    
                    //update player score
                    scoreTwo += 1
                    
                    var b1 = self.view.viewWithTag(comb[0] + 1)
                    b1?.tintColor = .systemYellow
                    var b2 = self.view.viewWithTag(comb[1] + 1)
                    b2?.tintColor = .systemYellow
                    var b3 = self.view.viewWithTag(comb[2] + 1)
                    b3?.tintColor = .systemYellow
                }
                
            }
            
        }
        
        
        
        /*
         DRAW
           check if theres a DRAW
         - makes sure it isnt considered drawn when won
         */
        if (gameRunning) {
            var drawCount = 0
            for pos in tileValue {
                if pos != 0 {
                    drawCount += 1
                }
            }
            
            if drawCount == 9 {
                turnLabel.text = "Draw"
                
                for button in buttons {
                    button.tintColor = .systemGray
                }
            }
        }
        
        
      
    
    }
    

}

/*
 MODEL
    - manages the game logic
        - game won/drew/running
 */
struct model {
    var isRunning: Bool = true
    var boardState: [[Bool]]
    
    func gameHasBeenWon() -> Bool {
        
        return !isRunning
    }
    
    
    //checks if the game has been won and gives winnder
    func checkWin(_ board: [Int], _ winComb: [Int]) -> Int {
      return 1
    }
    
    
    
}

/*
 - highlight winning combo with button shading
 -update score board *DONE*
 - reset button to base states, undo winning player color and make it say player one turn
 - glow thing when someone wins
 - change pics - *DONE*
 - alternating player - *DONE*
 - checks if draw *DONE*
 - change color when win*
 
 */



