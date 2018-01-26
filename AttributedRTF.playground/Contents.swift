//: Playground - noun: a place where people can play

import Swift
import Cocoa

let string1 = "The Quick Brown Fox Jumped over the Lazy Dog\r"
let string2 = "Thè Qúîck Brøwn Föx 🦊 Jumped over the Lazy Dóg 🐩"
let attrString = NSAttributedString(string: string1 + string2)

let range = NSRange(location: 0, length: attrString.string.count)

if let data = attrString.rtf(from: range, documentAttributes: [NSAttributedString.DocumentAttributeKey.characterEncoding : String.Encoding.utf8, NSAttributedString.DocumentAttributeKey.documentType : NSAttributedString.DocumentType.rtf]) {

    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let url = dir.appendingPathComponent("quickbrownfox.rtf")
        try! data.write(to: url, options: Data.WritingOptions.atomic)
    }
}
