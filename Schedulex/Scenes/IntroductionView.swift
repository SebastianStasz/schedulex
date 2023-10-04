//
//  IntroductionView.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 03/10/2023.
//

import SwiftUI
import Widgets

struct IntroductionView: View {
    @Binding var isFacultiesListPresented: Bool

    var body: some View {
        VStack(spacing: 50) {
            Image("logo_uek")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)

            VStack(spacing: .small) {
                Text("UEK Schedule")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.textPrimary)
                    .opacity(0.8)

                Text("Aby zacząć wybierz grupy, które chcesz obserwować i widzieć na stronie głównej")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .xlarge)
                    .foregroundStyle(.grayShade1)

                Button(action: presentFacultiesList) {
                    Text("Zaczynajmy")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal, .large)
                        .padding(.vertical, .small)
                }
                .buttonStyle(.borderedProminent)
                .tint(.accentPrimary)
                .padding(.top, 30)
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
