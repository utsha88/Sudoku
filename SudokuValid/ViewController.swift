//
//  ViewController.swift
//  SudokuValid
//
//  Created by Utsha Guha on 23-4-18.
//  Copyright © 2018 Utsha Guha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let flag = self.isValidSudoku(
            [["5","3",".",".","7",".",".",".","."],
             ["6",".",".","1","9","5",".",".","."],
             [".","9","8",".",".",".",".","6","."],
             ["8",".",".",".","6",".",".",".","3"],
             ["4",".",".","8",".","3",".",".","1"],
             ["7",".",".",".","2",".",".",".","6"],
             [".","6",".",".",".",".","2","8","."],
             [".",".",".","4","1","9",".",".","5"],
             [".",".",".",".","8",".",".","7","9"]])
        print(flag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        for i in 0..<board.count{
            var myRowSet = Set<Character>()
            var myRowArray = Array<Character>()
            var myColSet = Set<Character>()
            var myColArray = Array<Character>()
            for j in 0..<board.count{
                myRowSet.insert(board[i][j])
                myRowArray.append(board[i][j])
                
                myColSet.insert(board[j][i])
                myColArray.append(board[j][i])
            }
            myRowArray = myRowArray.filter{ $0 != "."}
            myRowSet.remove(".")
            myColArray = myColArray.filter{ $0 != "."}
            myColSet.remove(".")
            
            if (Array(myRowSet).sorted() != myRowArray.sorted())
                || (Array(myColSet).sorted() != myColArray.sorted()) {
                return false
            }
        }
        let result = self.checkDuplicateIn3by3Matrix(board: board, rowIndex: 0, colIndex: 0)
        return result
    }
    
    func checkDuplicateIn3by3Matrix(board:[[Character]],rowIndex:Int, colIndex:Int) -> Bool {
        var tmpRow = rowIndex
        while tmpRow<board.count {
            var mySet = Set<Character>()
            var myArray = Array<Character>()
            for i in tmpRow..<tmpRow+3{
                for j in colIndex..<colIndex+3{
                    mySet.insert(board[i][j])
                    myArray.append(board[i][j])
                }
            }
            myArray = myArray.filter{ $0 != "."}
            mySet.remove(".")
            if (Array(mySet).sorted() != myArray.sorted()) {
                return false
            }
            
            tmpRow = tmpRow + 3
            if tmpRow == 9 {
                if colIndex+3<9 {
                    let result = self.checkDuplicateIn3by3Matrix(board: board, rowIndex: 0, colIndex: colIndex+3)
                    return result
                }
            }
        }
        return true
    }

}

