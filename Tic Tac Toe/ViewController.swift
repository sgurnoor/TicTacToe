//
//  ViewController.swift
//  Tic Tac Toe
//
//  Created by Gurnoor Singh on 11/28/15.
//  Copyright © 2015 Cyberician. All rights reserved.
//

import UIKit
import FBSDKCoreKit

import FBSDKLoginKit




class ViewController: UIViewController{
    
    @IBOutlet weak var welcomeUser: UILabel!
    let game = TicTacToe()
    @IBOutlet weak var welcomeImage: UIImageView!
    
    @IBOutlet weak var gameLabel: UILabel!
    
    @IBOutlet var gameButtons: [UIButton]!

    @IBAction func markTile(sender: UIButton) {
        
        let row = sender.tag / 3
        let col = sender.tag % 3
        
        if let player = game.markTileInRow(row, andColumn: col) {
            sender.setTitle(player.rawValue, forState: UIControlState.Normal)
        }
        
        if let winner = game.getWinner() {
            
           updateLabelWithWinner(winner)
            
            for tile in gameButtons {
                tile.enabled = false
            }
            
        } else {
            updateLabelWithWinner(nil)
        }
        
        if game.checkTie() {
            gameLabel.text = "The game is tied"
            for tile in gameButtons {
                tile.enabled = false
            }
        }
        
    }
    
    private func updateLabelWithWinner (winner: TicTacToe.Player?) {
        if winner == nil {
            gameLabel.text = "Player \(game.playerToPlay.rawValue)'s turn"
        } else {
            gameLabel.text = "Player \(winner!.rawValue) won"
        }
        
    }

    
    
    @IBAction func resetButton(sender: UIButton) {
        game.resetGame()
        updateLabelWithWinner(nil)
        for tile in gameButtons {
            tile.enabled = true
            tile.setTitle("", forState: UIControlState.Normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Create request for user's Facebook data
        let request = FBSDKGraphRequest(graphPath:"me", parameters:nil)
        
        // Send request to Facebook
        request.startWithCompletionHandler {
            
            (connection, result, error) in
            
            if error != nil {
                // Some error checking here
            }
            else if let userData = result as? [String:AnyObject] {
                
                // Access user data
                let username = userData["name"] as? String
                let userImage = userData["Image"] as? UIImageView
                self.welcomeUser.text = username
                self.welcomeImage = userImage
                // ....
            }
        }
        
        
        updateLabelWithWinner(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

