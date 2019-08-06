//
//  Document.swift
//  iCloudTextEditor
//
//  Created by Elyanil Liranzo Castro on 8/6/19.
//  Copyright © 2019 Elyanil Liranzo Castro. All rights reserved.
//

import UIKit

enum FileError: Error {
    case invalidData
}

class Document: UIDocument {
    
    var text: String =  ""
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        return Data(text.utf8)
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        guard let contents = contents as? Data else {
            throw FileError.invalidData
        }
        
        text = String(decoding: contents, as: UTF8.self)
        
    }
}

