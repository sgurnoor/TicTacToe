//
//  TicTacToe.swift
//  Tic Tac Toe
//
//  Created by Gurnoor Singh on 11/28/15.
//  Copyright © 2015 Cyberician. All rights reserved.
//

import Foundation

import UIKit


class TicTacToe: CustomStringConvertible {
    enum Player: String {
        case X
        case O
    }
    
    var board = [[Player?]]()
    var playerToPlay = Player.X
    let boardSize: Int
    
    
    func markTileInRow(row: Int, andColumn col: Int) -> Player? {
        
        if (row >= 0 && row < boardSize && col >= 0 && col < boardSize && board[row][col] == nil) {
            board[row][col] = playerToPlay
            let playerToReturn = playerToPlay
            
            if playerToPlay == .X {
                playerToPlay = .O
            }
            else {
                playerToPlay = .X
            }
            
            return playerToReturn
        }
        return nil
    }
    
    var description: String {
        get {
            return "\(board)"
        }
        
    }
    
    init(size: Int = 3) {
        boardSize = size
        resetGame()
    }
    
    private func checkWinner(player: Player) -> Bool {
        //check rows
        for row in board {
            var count = 0
            
            for tile in row {
                if(tile == player) {
                    count++
                }
            }
            if (count == boardSize) {
                return true
            }
        }
        
        
        //check cols
        for var col = 0; col < boardSize; col++ {
            
            var count = 0
            
            for var row = 0; row < boardSize; row++ {
                if (board[row][col] == player) {
                    count++
                }
            }
            if (count == boardSize) {
                return true
            }
        }
        
        //check diagonal(top-left to bottom-right
        var count = 0
        for var i = 0; i < boardSize; i++ {
            
            if (board[i][i] == player) {
                count++
            }
        }
        if (count == boardSize) {
            return true
        }
        
        //check diagonal(top-right to bottom-left
        count = 0
        for var i = 0; i < boardSize; i++ {
            if (board[i][boardSize - i - 1] == player) {
                count++
            }
        }
        if (count == boardSize) {
            return true
        }
        
        return false
    }
    
    func getWinner() -> Player? {
        if (checkWinner(Player.X)) {
            return Player.X
        }
        else if (checkWinner(Player.O)) {
            return Player.O
        }
        else {
            return nil
        }
        
    }
    
    func checkTie () -> Bool {
        var count = 0
        for row in board {
            
            for tile in row {
                if (tile != nil) {
                    count++
                }
            }
        }
        if (count >= boardSize * boardSize) {
            return true
        }
        return false
    }
    
    func resetGame() {
        playerToPlay = Player.X
        board = Array(count: boardSize, repeatedValue: Array(count: boardSize, repeatedValue: nil))
    }
}
