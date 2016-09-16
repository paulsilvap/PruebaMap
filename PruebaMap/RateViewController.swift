//
//  RateViewController.swift
//  PruebaMap
//
//  Created by Paul Silva on 8/4/16.
//  Copyright © 2016 Paul Silva. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cosmos
import Alamofire

class RateViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var rateController: CosmosView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let placeholderText = "Escribe tu comentario o sugerencia."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.blackColor().CGColor
        nameTextField.layer.cornerRadius = 5
        
        commentTextView.editable = true
        commentTextView.selectable = true
        commentTextView.font = UIFont.systemFontOfSize(17)
        commentTextView.userInteractionEnabled = true
        commentTextView.multipleTouchEnabled = true
        commentTextView.backgroundColor = UIColor.clearColor()
        commentTextView.layer.cornerRadius = 5
        commentTextView.layer.borderWidth = 1
        commentTextView.layer.borderColor = UIColor.blackColor().CGColor
        applyPlaceholderStyle(commentTextView, placeholderText: placeholderText)
        commentTextView.delegate = self
        
        rateController.rating = 0
        rateController.settings.fillMode = .Half
        rateController.didFinishTouchingCosmos = {
            rating in
            print(rating)
        }
        rateController.settings.minTouchRating = 0
        rateController.settings.updateOnTouch = true
    }
    
    // MARK: - Actions
    
    @IBAction func sendButton(sender: UIButton) {
        
    }
    
    // MARK: - Delegate Methods
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if textView == commentTextView && textView.text == placeholderText {
            // move cursor to start
            moveCursorToStart(textView)
        }
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if textView == commentTextView && textView.text == placeholderText {
            moveCursorToStart(textView)
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        // remove the placeholder text when users start typing
        let newLength = textView.text.utf16.count + text.utf16.count - range.length
        if newLength > 0 {
            if textView == commentTextView && textView.text == placeholderText {
                if text.utf16.count == 0 {
                    return false
                }
                applyNonPlaceholderStyle(textView)
                textView.text = ""
            }
            return true
        } else {
            applyPlaceholderStyle(textView, placeholderText: placeholderText)
            moveCursorToStart(textView)
            return false
        }
    }
    
    func saveRating() {
        
    }
    
    // MARK: - Helper Functions
    
    func applyPlaceholderStyle(textView: UITextView, placeholderText: String) {
        // make it look (initially) like a placeholder
        textView.textColor = UIColor.lightGrayColor()
        textView.text = placeholderText
    }
    
    func applyNonPlaceholderStyle(textView: UITextView) {
        // make text look normal again
        textView.textColor = UIColor.darkTextColor()
        textView.alpha = 1.0
    }
    
    func moveCursorToStart(textView: UITextView) {
        dispatch_async(dispatch_get_main_queue(), {
            textView.selectedRange = NSMakeRange(0, 0)
        })
    }
    
}
