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
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.setUIBarButtonItemColorToClear()
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
