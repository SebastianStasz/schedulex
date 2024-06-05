//
//  SendEmailPresenter.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 07/01/2024.
//

import MessageUI
import UIKit

final class SendEmailPresenter: ObservableObject {
    @Published var isSendEmailViewPresented = false

    func sendMail(emailContent: EmailContent) {
        if MFMailComposeViewController.canSendMail() {
            isSendEmailViewPresented = true
        } else if let mailUrl = createMailUrl(emailContent: emailContent) {
            UIApplication.shared.open(mailUrl)
        }
    }

    private func createMailUrl(emailContent: EmailContent) -> URL? {
        let subject = emailContent.subject
        let recipient = emailContent.recipient

        let gmailUrl = URL(string: "googlegmail://co?to=\(recipient)&subject=\(subject)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(recipient)&subject=\(subject)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(recipient)&subject=\(subject)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(recipient)&subject=\(subject)")
        let defaultUrl = URL(string: "mailto:\(recipient)?subject=\(subject)")

        if let gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }

        return defaultUrl
    }
}
