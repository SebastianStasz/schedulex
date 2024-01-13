//
//  IntroductionView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import Resources
import SwiftUI
import Widgets

struct IntroductionView: View {
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            Image(.logoUek)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 160)
                .padding(.bottom, .large)

            Text("UEK Schedule")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.textPrimary)

            Spacer()
            Spacer()

            VStack(alignment: .leading, spacing: 32) {
                introductionPoint(title: L10n.introductionPoint1, icon: "calendar")
                introductionPoint(title: L10n.introductionPoint2, icon: "bell.fill")
                introductionPoint(title: L10n.introductionPoint3, icon: "eye.slash.fill")
            }

            Spacer()
            Spacer()

            Button(action: onContinue) {
                Text(L10n.introductionButtonTitle, style: .titleSmall)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, .large)
                    .foregroundStyle(.white)
                    .background(.accentPrimary)
                    .cornerRadius(.large)
            }
        }
        .padding(.bottom, bottomSpacing)
        .padding(.horizontal, .large)
        .padding(.top, .large)
    }

    func introductionPoint(title: String, icon: String) -> some View {
        HStack(spacing: .xlarge) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34)
                .foregroundStyle(.accentPrimary)

            Text(title, style: .bodyMedium)
        }
    }

    private var bottomSpacing: CGFloat {
        UIDevice.current.hasNotch ? 40 : .large
    }
}

#Preview {
    IntroductionView(onContinue: {})
}
