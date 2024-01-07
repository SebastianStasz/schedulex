//
//  SendEmailViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 06/01/2024.
//

import MessageUI
import SwiftUI

final class SendEmailViewController: NSObject, MFMailComposeViewControllerDelegate {
    private let dismiss: DismissAction

    init(dismiss: DismissAction) {
        self.dismiss = dismiss
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss.callAsFunction()
    }
}
