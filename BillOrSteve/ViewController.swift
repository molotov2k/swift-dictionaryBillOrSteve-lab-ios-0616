//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var steveLabel: UILabel!
    @IBOutlet weak var steveButtonOutlet: UIButton!
    @IBOutlet weak var billLabel: UILabel!
    @IBOutlet weak var billButtonOutlet: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    var facts: [String:[String]] = [:]
    var correctAnswers = 0
    var totalAnswers = 0
    var guy = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createFacts()
        startNextRound()
    }

    
    func randomNumberFromZeroTo(number: Int) -> Int {
        return Int(arc4random_uniform(UInt32(number)))
    }
    
    
    func showRandomFact() {

        if !facts.isEmpty {
            guy = Array(facts.keys)[randomNumberFromZeroTo(facts.count)]
            
            if var guyFacts = facts[guy] {
                let fact = guyFacts.removeAtIndex(randomNumberFromZeroTo(guyFacts.count))
                if guyFacts.count == 0 {
                    facts.removeValueForKey(guy)
                } else {
                    facts[guy] = guyFacts
                }
                factLabel.text = fact
            }
            
        } else {
            
            guy = ""
            steveLabel.hidden = true
            steveButtonOutlet.hidden = true
            billLabel.hidden = true
            billButtonOutlet.hidden = true
            bottomView.hidden = true
            scoreLabel.hidden = true
            factLabel.text = "There are no more facts left!\n\nYour correctly answered to \(correctAnswers) out of \(totalAnswers) questions."
            factLabel.font = UIFont.boldSystemFontOfSize(22)
            
        }
    }
    
    
    func startNextRound() {
        showRandomFact()
        scoreLabel.text = "\(correctAnswers) / \(totalAnswers)"
        if !guy.isEmpty {
            totalAnswers += 1
        }
    }
    
    
    @IBAction func steveButton(sender: AnyObject) {
        checkAnswerAndStartRoundWithDelay("Steve Jobs")
    }
    
    
    @IBAction func billButton(sender: AnyObject) {
        checkAnswerAndStartRoundWithDelay("Bill Gates")
    }
    
    
    func startRoundWithDelay() {
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 1 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.startNextRound()
        }
    }
    
    
    func checkAnswerAndStartRoundWithDelay (answer: String) {
        if guy == answer {
            correctAnswers += 1
            factLabel.text = "Correct!\n\nGood job!"
        } else {
            factLabel.text = "Wrong!\n\nShame on you!"
        }
        startRoundWithDelay()
    }
    
    
    func createFacts() {
        facts = [
            "Steve Jobs" : [
                "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
                "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
                "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
                "He was a pescetarian, meaning he ate no meat except for fish.",
            ],
            
            "Bill Gates" : [
                "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
                "He scored 1590 (out of 1600) on his SATs.",
                "His foundation spends more on global health each year than the United Nation's World Health Organization.",
                "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
                "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss.",
            ],
            
        ]
    }
    
    
}
