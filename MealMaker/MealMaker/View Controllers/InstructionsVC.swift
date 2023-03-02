//
//  InstructionsVC.swift
//  MealMaker
//
//  Created by iMac Pro on 3/2/23.
//

import UIKit

class InstructionsVC: UIViewController {
    
    //MARK: - OUTLETS
    @IBOutlet weak var instructionsTextView: UITextView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    
    //MARK: - PROPERTIES
    var instructions: String?
    
    
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let instructions = instructions else { return }
        instructionsTextView.text = instructions
    }
    
}
