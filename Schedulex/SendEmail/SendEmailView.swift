//
//  SendEmailView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import MessageUI
import SwiftUI

struct EmailContent {
    let subject: String
    let recipient: String

    static let `default` = EmailContent(subject: "UEKSchedule", recipient: "sebastianstaszczyk.1999@gmail.com")
}

struct SendEmailView: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    let emailContent: EmailContent

    func makeCoordinator() -> SendEmailViewController {
        SendEmailViewController(dismiss: dismiss)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<SendEmailView>) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = context.coordinator
        mailViewController.setToRecipients([emailContent.recipient])
        mailViewController.setSubject(emailContent.subject)
        return mailViewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<SendEmailView>) {}
}
