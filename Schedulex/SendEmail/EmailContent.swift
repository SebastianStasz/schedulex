//
//  EmailContent.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/01/2024.
//

import Domain
import Foundation
import Resources

struct EmailContent {
    let subject: String
    let recipient: String
    let body: String?

    static func defaultContact(recipient: String?, appVersion: String?, facultyGroups: [FacultyGroup]) -> EmailContent? {
        guard let recipient, let appVersion else { return nil }
        let facultyGroups = facultyGroups.map { $0.name }.joined(separator: ", ")
        let bodyContent = facultyGroups.isEmpty ? "" : "\(L10n.observedTitle): \(facultyGroups)"
        return EmailContent(subject: "UEKSchedule \(appVersion)", recipient: recipient, body: bodyContent)
    }
}
