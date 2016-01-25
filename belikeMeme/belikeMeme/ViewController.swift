//
//  ViewController.swift
//  belikeMeme
//
//  Created by Aysin Kuran on 1/25/16.
//  Copyright © 2016 Aysin Kuran. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    var memes: [BillMeme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBOutlet weak var thisIsXText: UITextField!
   
    @IBOutlet weak var wiseText: UITextView!

    @IBOutlet weak var beText: UITextField!
    
    @IBOutlet weak var beLikeXText: UITextField!
    
    @IBOutlet weak var billImage: UIImageView!
    
    @IBOutlet weak var toolBar: UIToolbar!
    @IBAction func changeImage(sender: AnyObject) {
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardwilhideNotifications()
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
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardwillhideNotifications()
        
    }
    
    @IBAction func shareAction(sender: UIBarButtonItem) {
        
            let saveMemeImage = generateMemedImage()
            let activityVC = UIActivityViewController(activityItems: [saveMemeImage], applicationActivities: nil)
            activityVC.completionWithItemsHandler = {
                (s: String?, ok: Bool, items: [AnyObject]?, err:NSError?) -> Void in self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
            
            presentViewController(activityVC, animated: true, completion: nil)
        
    }
    

    
    //all functions necessary to input the Text Fields
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
    //all functions necessary to move the view up & down for the Bottom Text Field
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if beLikeXText.editing {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
        else {
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if beLikeXText.editing {
            self.view.frame.origin.y += setKeyboardHeight(notification)
        }
        else {
        }
    }
    
    func subscribeToKeyboardwilhideNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func setKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self,name: UIKeyboardWillShowNotification,object: nil)
    }
    
    func unsubscribeFromKeyboardwillhideNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    //all functions necessary to create a memeImage and save it with the related fields
    
    func save() {
        let meme = BillMeme(thisIsXText: thisIsXText!.text!  , wiseText: wiseText!.text! , beText: beText.text!, beLikeXText: beLikeXText.text!, billImage: billImage.image!, memedImage: generateMemedImage())
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        
        toolBar.hidden = true
        
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolBar.hidden = false
        
        return memedImage
    }
    



}



