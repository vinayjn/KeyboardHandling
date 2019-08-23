# KeyboardHandling

Lightweight keyboard events wrapper which makes keyboard handling in iOS devices easy.


## Usage

Just add `KeyboardHandler.swift` in your project.

**Step 1:** Start the global listener by adding the following line to your `AppDelegate` or any other place you want to handle the keyboard.

```swift
KeyboardHandler.shared.startListening()
```

**Step 2:** Add observer for `UIKeyboardFrameChangeNotification` in your Viewcontroller. A typical usage looks like this

```swift

override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardFrameChanged(notification:)), name: UIKeyboardFrameChangeNotification, object: nil)
}

override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
}


@objc private func keyboardFrameChanged(notification: Notification) -> Void {
    
    let heightChange = notification.userInfo!["height"] as! CGFloat
    let duration = notification.userInfo!["animationDuration"] as! TimeInterval
    let curve = notification.userInfo!["animationOption"] as! UIView.AnimationOptions

    UIView.animate(withDuration: duration, delay: 0.0, options: [curve], animations: {
        
        // Do some animation here

    }, completion: nil)
}

```

Use the following code to stop listening to keyboard events.

```swift
KeyboardHandler.shared.stopListening()
```

Please feel free to raise issues and pull requests if you find any problems or improvements in the code.