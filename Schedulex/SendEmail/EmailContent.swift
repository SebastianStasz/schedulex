//
//  EmailContent.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/01/2024.
//

import Foundation

struct EmailContent {
    let subject: String
    let recipient: String

    static func defaultContact(recipient: String) -> EmailContent {
        EmailContent(subject: "UEKSchedule", recipient: recipient)
    }
}
