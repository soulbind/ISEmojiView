//
//  EmojiKeyboardViewController.swift
//  ISEmojiViewExample
//
//  Created by Beniamin Sarkisyan on 03/08/2018.
//

import UIKit
import ISEmojiView

class EmojiKeyboardViewController: UIViewController, EmojiViewDelegate {
    
    // MARK: - Public variables
    
    var bottomType: BottomType!
    var emojis: [EmojiCategory]?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var textView: UITextView!
    
    // MARK: - Override functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Support "Dark Mode"
        if #available(iOS 13.0, *) {
            textView!.textColor = .label
        }
        
        let keyboardSettings = KeyboardSettings(bottomType: bottomType)
        keyboardSettings.needToShowAbcButton = true
        keyboardSettings.customEmojis = emojis
        keyboardSettings.countOfRecentsEmojis = 20
        keyboardSettings.updateRecentEmojiImmediately = true
        let emojiView = EmojiView(keyboardSettings: keyboardSettings)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.delegate = self
        textView.inputView = emojiView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    // MARK: - EmojiViewDelegate
    
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
        textView.insertText(emoji)
    }
    
    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
        textView.inputView = nil
        textView.keyboardType = .default
        textView.reloadInputViews()
    }
    
    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
        textView.deleteBackward()
    }
    
    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
        textView.resignFirstResponder()
    }
    
}
