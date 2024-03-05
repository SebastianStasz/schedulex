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

    static func defaultContact(recipient: String?, appVersion: String?) -> EmailContent? {
        guard let recipient, let appVersion else { return nil }
        return EmailContent(subject: "UEKSchedule \(appVersion)", recipient: recipient)
    }
}
