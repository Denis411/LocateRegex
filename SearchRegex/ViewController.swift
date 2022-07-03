//
//  ViewController.swift
//  SearchRegex
//
//  Created by Dennis on 7/3/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    let font = UIFont(name: "TimesNewRoma", size: 14)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.font = font
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        findText()
    }
    
    private func findText() {
        guard let input = searchField.text,
              let textInView = textView.text else { return }
        var regex = NSRegularExpression()
        
        do {
            regex = try NSRegularExpression(pattern: "\(input)")
        } catch {
            print(error.localizedDescription)
            return
        }
        
        let attributedString: NSMutableAttributedString =
            NSMutableAttributedString(string: textView.text)
        let range = NSRange(location: 0, length: textView.text.utf16.count)
        let matches = regex.matches(in: textInView, range: range)
        
        matches.forEach { match in
            attributedString.addAttribute(.backgroundColor, value: UIColor.red, range: match.range)
        }

        self.textView.attributedText = attributedString
    }
}

