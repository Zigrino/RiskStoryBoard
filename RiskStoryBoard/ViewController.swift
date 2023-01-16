//
//  ViewController.swift
//  RiskStoryBoard
//
//  Created by Yulian Itskov-Curto on 1/14/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var AttackersPopUp: UIButton!
    @IBOutlet weak var DefendersPopUp: UIButton!
    @IBOutlet weak var SingleAttackButton: UIButton!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var ToDeathButton: UIButton!
    var attacking_num: Int = 1
    var defending_num: Int = 1
    var result: [Int] = [0, 0, 0]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setPopupButton()
        setAttackButtons()
    }
    func setAttackButtons(){
        ToDeathButton.addTarget(self, action: #selector(singleAttack(_:)), for: .touchUpInside)
        SingleAttackButton.addTarget(self, action: #selector(toDeath(_:)), for: .touchUpInside)
    }
    func setResult(){
        if(self.result[1] == 0){
            ResultLabel.text = "Attackers win with \(self.result[0]-self.result[2]) attackers left in the original territory and \(self.result[2]) attackers left in the new territory"
        }
        else if(self.result[0] <= 1){
            ResultLabel.text = "Defenders win with \(self.result[1]) left"
        }
        else{
            ResultLabel.text = "\(self.result[0]-self.result[2]) Attackers left in original territory,\n \(self.result[2]) attackers left in attacked territory,\n \(self.result[1]) defenders left"
        }
    }
    
    @IBAction func toDeath(_ sender: UIButton){
        if(self.defending_num<1){
            return
        }
        print("fighting to death")
        print(attacking_num, defending_num)
        self.result = fightToDeath(att: attacking_num, def: defending_num)
        print("result \(self.result)")
        self.attacking_num = self.result[0]
        self.defending_num = self.result[1]
        setPopupButton()
        setResult()
    }
    @IBAction func singleAttack(_ sender: UIButton){
        if(defending_num<1){
            return
        }
        print("doing a single attack")
        print(attacking_num, defending_num)
        if (attacking_num>3 && defending_num>=2){
            print("attacking 3 on 2")
            self.result = rollDice(att: attacking_num, def: defending_num, attackNum: 3, defendingNum: 2)
        }
        else if(attacking_num<=3 && defending_num>=2){
            print("attacking \(attacking_num-1) on 2")
            self.result = rollDice(att: attacking_num, def: defending_num, attackNum: attacking_num-1, defendingNum: 2)
        }
        else if(attacking_num>3 && defending_num<2){
            print("attacking 3 on \(defending_num)")
            self.result = rollDice(att: attacking_num, def: defending_num, attackNum: 3, defendingNum: defending_num)
        }
        else{
            print("attacking \(attacking_num-1) on \(defending_num)")
            self.result = rollDice(att: attacking_num, def: defending_num, attackNum: attacking_num-1, defendingNum: defending_num-1)
        }
        print("result \(self.result)")
        self.attacking_num = self.result[0]
        self.defending_num = self.result[1]
        setPopupButton()
        setResult()
    }
    func setPopupButton(){
        let optionClosureA = {(action : UIAction) in
            self.attacking_num = Int(action.title) ?? 0
            print(self.attacking_num)
        }
        let optionClosureD = {(action : UIAction) in
            self.defending_num = Int(action.title) ?? 0
            print(self.defending_num)
        }
        
        var element_list = [UIAction(title: String(attacking_num), state: .on, handler: optionClosureA)]
        var element_listd = [UIAction(title: String(defending_num), state: .on, handler: optionClosureD)]
        
        for i in 1...50{
            element_list.append(UIAction(title: String(i), handler: optionClosureA))

        }
        for i in 1...50{
            element_listd.append(UIAction(title: String(i), handler: optionClosureD))

        }
        AttackersPopUp.menu = UIMenu(children : element_list)
        AttackersPopUp.showsMenuAsPrimaryAction = true
        AttackersPopUp.changesSelectionAsPrimaryAction = true
        DefendersPopUp.menu = UIMenu(children : element_listd)
        DefendersPopUp.showsMenuAsPrimaryAction = true
        DefendersPopUp.changesSelectionAsPrimaryAction = true
    }
    


}

