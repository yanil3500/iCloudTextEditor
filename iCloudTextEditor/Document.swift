//
//  Document.swift
//  iCloudTextEditor
//
//  Created by Elyanil Liranzo Castro on 8/6/19.
//  Copyright © 2019 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

class Document: UIDocument {
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data()
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
    }
}

