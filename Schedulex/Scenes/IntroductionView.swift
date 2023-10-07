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
    @Binding var isFacultiesListPresented: Bool

    var body: some View {
        VStack(spacing: 40) {
            Image(.logoUek)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)

            VStack(spacing: .small) {
                Text("UEK Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)

                Text(L10n.letsStartMessage)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .xlarge)
                    .foregroundStyle(.grayShade1)

                Button(action: presentFacultiesList) {
                    Text(L10n.letsStart)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.vertical, .large)
                        .padding(.horizontal, 2 * .xlarge)
                        .background(.accentPrimary)
                        .cornerRadius(.large)
                }
                .buttonStyle(.plain)
                .padding(.top, 80)
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .padding(.top, 60)
    }

    private func presentFacultiesList() {
        isFacultiesListPresented = true
    }
}

#Preview {
    IntroductionView(isFacultiesListPresented: .constant(false))
}
