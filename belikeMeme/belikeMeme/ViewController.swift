//
//  ViewController.swift
//  belikeMeme
//
//  Created by Aysin Kuran on 1/25/16.
//  Copyright © 2016 Aysin Kuran. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var thisIsXText: UITextField!
   
    @IBOutlet weak var wiseText: UITextView!

    @IBOutlet weak var beText: UITextField!
    
    @IBOutlet weak var beLikeXText: UITextField!
    
    @IBOutlet weak var billImage: UIImageView!
    
    @IBAction func changeImage(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thisIsXText.text = "This is Bill"
        wiseText.text = "Add your text here.\nClick on any text to change it."
        beText.text = "Be Smart"
        beLikeXText.text = "Be like Bill"
        billImage.image = UIImage(named: "ThisisBill")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

