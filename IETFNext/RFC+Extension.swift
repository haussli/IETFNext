//
//  RFC+Extension.swift
//  IETFNext
//
//  Created by Tom Pusateri on 1/6/23.
//

import SwiftUI
import CoreData


extension RFC {
    var name2: String {
        if let compact = name {
            return compact.enumerated().compactMap({ ($0  == 3) ? " \($1)" : "\($1)" }).joined()
        }
        return "Unnamed"
    }

    var shortStream: String {
        if let orig = stream {
            switch(orig) {
            case "IAB", "IETF", "IRTF":
                return orig
            case "INDEPENDENT":
                return "INDP"
            case "Legacy":
                return "LEGC"
            default:
                return orig
            }
        }
        return "NONE"
    }

    var shortStatus: String {
        switch(currentStatus) {
        case "BEST CURRENT PRACTICE":
            return "BCP"
        case "DRAFT STANDARD":
            return "DS"
        case "EXPERIMENTAL":
            return "EXP"
        case "HISTORIC":
            return "HIST"
        case "INFORMATIONAL":
            return "INFO"
        case "INTERNET STANDARD":
            return "IS"
        case "PROPOSED STANDARD":
            return "PS"
        default:
            return "UNKN"
        }
    }

    var color: Color {
        switch(currentStatus) {
        case "BEST CURRENT PRACTICE":
            return Color(hex: 0x795548) // brown
        case "DRAFT STANDARD":
            return Color(hex: 0xf44336) // red
        case "EXPERIMENTAL":
            return Color(hex: 0x9c27b0) // magenta
        case "HISTORIC":
            return Color(hex: 0x607d8b) // blue gray
        case "INFORMATIONAL":
            return Color(hex: 0x009688) // green
        case "INTERNET STANDARD":
            return Color(hex: 0x673ab7) // purple
        case "PROPOSED STANDARD":
            return Color(hex: 0x3f51b5) // dark blue
        default:
            return Color.secondary
        }
    }
}