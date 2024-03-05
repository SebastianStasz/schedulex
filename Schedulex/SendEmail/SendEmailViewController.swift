//
//  SendEmailViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import MessageUI
import SwiftUI

final class SendEmailViewController: MFMailComposeViewController, MFMailComposeViewControllerDelegate {
    private let emailContent: EmailContent

    init(emailContent: EmailContent) {
        self.emailContent = emailContent
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mailComposeDelegate = self
        setToRecipients([emailContent.recipient])
        setSubject(emailContent.subject)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
