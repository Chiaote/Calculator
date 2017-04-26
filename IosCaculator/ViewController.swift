//
//  ViewController.swift
//  IosCaculator
//
//  Created by 倪僑德 on 2017/2/17.
//  Copyright © 2017年 Chiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var caculatorMonitor: UILabel!
    var labelStorage = ""
    var lastOperator = ""
    var pointOption = false
    var lastValue = 0.0
    var lastValueExist = false
    
    
    @IBAction func numberButton(_ sender: UIButton) {
        if let inputValue = sender.titleLabel?.text{
            inputDotAndNumber(inputString: inputValue)
        }else{
            caculatorMonitor.text = "nothing input!"
        }
    }
    @IBAction func dotButton(_ sender: Any) {
        if caculatorMonitor.text == "0" || caculatorMonitor.text == ""{
            labelStorage = "0."
            caculatorMonitor.text = labelStorage
        }else{
            inputDotAndNumber(inputString: ".")
        }
        
    }
    @IBAction func operatorButton(_ sender: UIButton) {
        let inputOperator = sender.titleLabel?.text
        caculatorFunc()
        lastOperator = inputOperator!
    }
    @IBAction func ACButton(_ sender: Any) {
        labelStorage = ""
        pointOption = false
        lastValue = 0.0
        lastValueExist = false
        lastOperator = ""
        labelToScreen()
    }
    @IBAction func posAndNegButton(_ sender: Any) {
        if var valueTemp = Double(labelStorage) {
            valueTemp = 0 - valueTemp
            labelStorage = String(valueTemp)
        }else{
            labelStorage = "labelStorage is nil"
        }
        labelToScreen()
    }
    @IBAction func percentButton(_ sender: Any) {
        if var valueTemp = Double(labelStorage) {
            valueTemp = valueTemp/100
            labelStorage = String(valueTemp)
        }else{
            labelStorage = "labelStorage is nil"
        }
        labelToScreen()
        
    }
    @IBAction func ansButton(_ sender: Any) {
        caculatorFunc()
        lastValueExist = false
    }
    //數字＆點呼叫的func
    func inputDotAndNumber(inputString:String){
        if inputString == "." && pointOption == false{
            pointOption = true
            labelStorage = labelStorage + inputString
        }else if inputString == "."{
        }else{
            labelStorage = labelStorage + inputString
        }
        labelToScreen()
        
    }
    //計算數值的func
    func caculatorFunc(){
        if var newLabel = caculatorMonitor.text{
            if newLabel.characters.last == "."{
                newLabel = String(newLabel.characters.dropLast())
            }
            if lastValueExist{
                let currentValue = Double(newLabel)!
                self.caculateAct(currentValue: currentValue)
                labelStorage = String(lastValue)
                labelToScreen()
                labelStorage = ""
            }else{
                lastValue = Double(newLabel)!
                lastValueExist = true
                labelStorage = ""
            }
        }
    }
    func caculateAct(currentValue:Double){
        switch lastOperator {
        case "+":
            lastValue = lastValue + currentValue
        case "-":
            lastValue = lastValue - currentValue
        case "x":
            lastValue = lastValue * currentValue
        case "/":
            lastValue = lastValue / currentValue
        default:
            caculatorMonitor.text = "Operator Button Wrong"
        }
        lastValueExist = true
    }
    func labelToScreen(){
        if let value = Double(labelStorage){
            if value == Double(Int(value)){
                labelStorage = String(Int(value))
            }
        }else{
            caculatorMonitor.text = "labelToScreen, labelStorage=nil"
        }
        caculatorMonitor.text = labelStorage
    }
}

