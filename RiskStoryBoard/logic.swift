//
//  logic.swift
//  RiskStoryBoard
//
//  Created by Yulian Itskov-Curto on 1/14/23.
//

import Foundation

func rollDice(att: Int, def: Int, attackNum: Int, defendingNum: Int) -> [Int]{
    if attackNum<1{
        return [1, def, 0]
    }
    var attackers: Int = att
    var defenders: Int = def
    //return array with first number of attackers in territory they started in, number of attackrs in new territory, number of defenders left
    var attacking_dice: [Int] = []
    var attackers_left: Int = attackNum
    for _ in 1...attackNum{
        attacking_dice.append(Int.random(in: 1...6))
    }
    
    var defending_dice: [Int] = []
    if defendingNum>1{
        for _ in 1...defendingNum{
            defending_dice.append(Int.random(in: 1...6))
        }
    } else{
        defending_dice.append(Int.random(in: 1...6))
    }
    attacking_dice.sort()
    defending_dice.sort()
    
    if(attacking_dice[attacking_dice.count-1] > defending_dice[defending_dice.count-1]){
        defenders-=1
    }
    if(attacking_dice[attacking_dice.count-1]<=defending_dice[defending_dice.count-1]){
        attackers-=1
        attackers_left-=1
    }
    if(attacking_dice.count>1 && defending_dice.count>1){
        if(attacking_dice[attacking_dice.count-2]>defending_dice[defending_dice.count-2]){
            defenders-=1
        }
        if(attacking_dice[attacking_dice.count-2]<=defending_dice[defending_dice.count-2]){
            attackers-=1
            attackers_left-=1
        }
    }
    print(attacking_dice)
    print(defending_dice)
    print(attackers)
    print(defenders)
    return [attackers, defenders, attackers_left] //the first value is the total amount of attackers, in enemy and original territory
}

func fightToDeath(att: Int, def: Int) ->[Int]{
    var attackers: Int = att;
    var defenders: Int = def;
    var attackersInTerritory: Int = attackers
    while(attackers>1 && defenders>0){
        if attackers>3{
            attackersInTerritory = 3
        } else{
            attackersInTerritory = attackers-1
        }
        if(attackers>3 && defenders>=2){
            var result: [Int] = rollDice(att: attackers, def: defenders, attackNum: 3, defendingNum: 2)
            attackers = result[0]
            defenders = result[1]
            attackersInTerritory = result[2]
        }
        else if(attackers<=3 && defenders>=2){
            var result: [Int] = rollDice(att: attackers, def: defenders, attackNum: attackers-1, defendingNum: 2)
            attackers = result[0]
            defenders = result[1]
            attackersInTerritory = result[2]

        }
        else if(attackers>3 && defenders<2){
            var result:[Int] = rollDice(att: attackers, def: defenders, attackNum: 3, defendingNum: defenders)
            attackers = result[0]
            defenders = result[1]
            attackersInTerritory = result[2]

        }
        else{
            var result: [Int] = rollDice(att: attackers, def: defenders, attackNum: attackers-1, defendingNum: defenders)
            attackers = result[0]
            defenders = result[1]
            attackersInTerritory = result[2]
        }
        
    }
    return [attackers, defenders, attackersInTerritory] // returns the number of attackers in the origin territory + number of attackers in attacked territory (total number), num of attackers in attacked territory, number of defenders.
    
}
