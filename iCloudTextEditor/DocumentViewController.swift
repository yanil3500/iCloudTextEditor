//
//  DocumentViewController.swift
//  iCloudTextEditor
//
//  Created by Elyanil Liranzo Castro on 8/6/19.
//  Copyright © 2019 Elyanil Liranzo Castro. All rights reserved.
//

import Sourceful
import UIKit

class DocumentViewController: UIViewController {
    @IBOutlet var textView: SyntaxTextView!
    var document: Document?
    
    let lexer: Lexer = SwiftLexer()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MARK: Sourceful setup 
        textView.theme = DefaultSourceCodeTheme()
        textView.delegate = self
        
        //Buttons to the navigation controller
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))
        
        // Access the document
        document?.open { success in
            if success {
                // Display the content of the document, e.g.:
                // Shows document name at the top of the navigation controller
                self.title = self.document?.fileURL.deletingPathExtension().lastPathComponent.capitalized
                self.textView.text = self.document?.text ?? ""
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        }
    }
    
    @objc func dismissDocumentViewController() {
        document?.text = textView.text
        document?.updateChangeCount(.done)
        
        dismiss(animated: true) { [weak self] in
            if let self = self {
                self.document?.close(completionHandler: nil)
            }
        }
    }
    
    @objc func shareTapped(sender: UIBarButtonItem) {
        guard let url = document?.fileURL else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = sender
        present(activityVC, animated: true)
    }
}

// MARK: SyntaxTextViewDelegate
extension DocumentViewController: SyntaxTextViewDelegate {
    func lexerForSource(_ source: String) -> Lexer {
        return lexer
    }
}
