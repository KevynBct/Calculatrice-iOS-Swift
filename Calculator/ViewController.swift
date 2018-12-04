//
//  ViewController.swift
//  Calculator
//
//  Created by formation9 on 28/11/2018.
//  Copyright © 2018 formation9. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultText: UILabel!
    var firstValue : String = ""
    var secondValue : String = ""
    var sign : String = ""
    var isResultJustCalculated : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onDigitTap(_ sender: UIButton) {
        if(isResultJustCalculated && sign == ""){
            firstValue = ""
            isResultJustCalculated = false
        }
        let buttonText = sender.titleLabel?.text ?? ""
        if(sign == ""){
            firstValue += buttonText
        }else{
            secondValue += buttonText
        }
        resultText.text = firstValue + sign + secondValue
    }
    
    @IBAction func onDeleteTap(_ sender: Any) {
        firstValue = ""
        sign = ""
        secondValue = ""
        resultText.text = ""
        isResultJustCalculated = false
    }
    
    @IBAction func onDotTap(_ sender: UIButton) {
        if(firstValue != "" && !firstValue.contains(".") && sign == ""){
            firstValue += sender.titleLabel?.text ?? ""
        }else if (firstValue.starts(with: "-") && firstValue.count > 1 && !firstValue.contains(".") && sign == ""){
            firstValue += sender.titleLabel?.text ?? ""
        }else if (secondValue != "" && !secondValue.contains(".")){
            secondValue += sender.titleLabel?.text ?? ""
        }
        resultText.text = firstValue + sign + secondValue
    }
    
    
    @IBAction func onOperatorTap(_ sender: UIButton) {
        if(sign == "" && firstValue != "" && !firstValue.starts(with: "-")){
            sign = sender.titleLabel?.text ?? ""
            resultText.text = firstValue + sign + secondValue
        }else if (firstValue.starts(with: "-") && sign == "" && firstValue.count > 1){
            sign = sender.titleLabel?.text ?? ""
            resultText.text = firstValue + sign + secondValue
        }else if (sign != "" && secondValue != ""){
            calculate()
            sign = sender.titleLabel?.text ?? ""
            resultText.text = firstValue + sign + secondValue
        }else if(firstValue == "" && sender.titleLabel?.text ?? "" == "-"){
            firstValue += "-"
            resultText.text = firstValue + sign + secondValue
        }
    }
    
    @IBAction func onEqualTap(_ sender: UIButton) {
        if(firstValue != "" && sign != "" && secondValue != ""){
            calculate()
        }else{
            print("Erreur  - Le calcul n'est pas complet")
        }
    }
    
    func calculate(){
        guard let firstDouble = Double(firstValue) else {
            return
        }
        guard let secondDouble = Double(secondValue)else {
            return
        }
        var result : Double
        switch (sign){
            case "+" : result = firstDouble + secondDouble
            case "-" : result = firstDouble - secondDouble
            case "/" : result = firstDouble / secondDouble
            case "x" : result = firstDouble * secondDouble
            default : result = 0.0
        }
        firstValue = String(result)
        sign = ""
        secondValue = ""
        resultText.text = String(result)
        isResultJustCalculated = true
    }
}

