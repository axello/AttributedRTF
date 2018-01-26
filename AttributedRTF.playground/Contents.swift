//: Playground - noun: a place where people can play

import Swift
import Cocoa

let string1 = "The Quick Brown Fox Jumped over the Lazy Dog\r"
let string2 = "Thè Qúîck Brøwn Föx 🦊 Jumped over the Lazy Dóg 🐩"

func localString() {
    let attrString = NSAttributedString(string: string1 + string2)
    let range = NSRange(location: 0, length: attrString.string.count)

    if let data = attrString.rtf(from: range, documentAttributes: [NSAttributedString.DocumentAttributeKey.characterEncoding : String.Encoding.utf8, NSAttributedString.DocumentAttributeKey.documentType : NSAttributedString.DocumentType.rtf]) {
    
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent("quickbrownfox_local.rtf")
            try! data.write(to: url, options: Data.WritingOptions.atomic)
        }
    }

}

/// read the RTF as a string, and add characters, as my main application is doing
func templateString() {
    let templatePath = Bundle.main.url(forResource:"template", withExtension: "rtf")!
    
    var rtfString = try! NSString(contentsOf:templatePath, encoding: String.Encoding.utf8.rawValue) as String
    rtfString += "\n" + string2
    // so, rtfString is a *normal* string, with RTF attributes
    // convert string to data
    if let data = rtfString.data(using: String.Encoding.utf8) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let url = dir.appendingPathComponent("quickbrownfox_template.rtf")
            try! data.write(to: url, options: Data.WritingOptions.atomic)
        }
    }
}

/// read the RTF as an attributed string, and add characters
func templateAttributedString() {
    let templatePath = Bundle.main.url(forResource:"template", withExtension: "rtf")!
    
    let data = try! Data(contentsOf: templatePath)
    var attr: NSDictionary? = NSDictionary()
    if let attrString1 = NSMutableAttributedString.init(rtf: data, documentAttributes: &attr) {
        var attrString: NSMutableAttributedString = attrString1
        attrString.append(NSAttributedString(string:"\n" + string2))
        print(attrString)
//        // so, attrString is an attributed string, with RTF attributes interpreted
//        // convert string to data
//    //    if let data = attrString.docFormat() {
        let range = NSRange(location: 0, length: attrString.string.count)

//        if let data = attrString.rtf(from: range, documentAttributes: [NSAttributedString.DocumentAttributeKey.characterEncoding : String.Encoding.utf8,
//                                                                       NSAttributedString.DocumentAttributeKey.documentType : NSAttributedString.DocumentType.rtf]) {

        if let data = attrString.rtf(from: range, documentAttributes: attr as! [NSAttributedString.DocumentAttributeKey: Any]) {
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let url = dir.appendingPathComponent("quickbrownfox_rtftemplate.rtf")
                try! data.write(to: url, options: Data.WritingOptions.atomic)
            }
        }
    }
}

localString()
templateString()
templateAttributedString()



