//
//  DocumentViewController.swift
//  iCloudTextEditor
//
//  Created by Elyanil Liranzo Castro on 8/6/19.
//  Copyright © 2019 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class DocumentViewController: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))
        
        // Access the document
        document?.open { success in
            if success {
                // Display the content of the document, e.g.:
                self.textView.text = self.document?.text ?? ""
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        }
    }
    
    @objc func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
