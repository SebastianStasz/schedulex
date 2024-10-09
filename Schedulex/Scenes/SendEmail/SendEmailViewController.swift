//
//  SendEmailViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import MessageUI
import SwiftUI

final class SendEmailViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    init(emailContent: EmailContent) {
        super.init(nibName: nil, bundle: nil)

        mailComposeDelegate = self
        setToRecipients([emailContent.recipient])
        setSubject(emailContent.subject)

        if let body = emailContent.body {
            setMessageBody(body, isHTML: false)
        }
    }

    func mailComposeController(_: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
        dismiss()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
