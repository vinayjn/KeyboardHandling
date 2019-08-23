//
//  KeyboardHandler.swift
//  KeyboardHandler
//
//  Created by Vinay Jain on 23/08/19.
//  Copyright © 2019 Vaivin. All rights reserved.
//

import UIKit

let UIKeyboardFrameChangeNotification = Notification.Name(rawValue: "kUIKeyboardFrameChangeNotification")

class KeyboardHandler {
    
    static let shared = KeyboardHandler()
    
    func startListening() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        adjustingHeight(true, notification: notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        adjustingHeight(false, notification: notification)
    }
    
    func adjustingHeight(_ show:Bool, notification:Notification) {
        
        var userInfo = (notification as NSNotification).userInfo!
        let keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as! Int
        let changeInHeight = (keyboardFrame.height ) * (show ? 1 : 0)
        
        NotificationCenter.default.post(
            name: UIKeyboardFrameChangeNotification,
            object: nil,
            userInfo: [
                "show": show,
                "height": changeInHeight,
                "animationDuration": animationDuration,
                "animationOption": UIView.AnimationOptions(rawValue: UInt(animationCurve << 16))
            ]
        )
    }
    
    func stopListening() {
        
        NotificationCenter.default.removeObserver(self)
    }
}
