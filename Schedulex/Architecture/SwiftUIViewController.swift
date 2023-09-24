//
//  SwiftUIViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 30/08/2023.
//

import SwiftUI
import SchedulexFirebase

class SwiftUIViewController<VM: ViewModel, View: RootView>: UIHostingController<View> where VM.Store == View.Store {
    private weak var store: RootStore?
    private var isFirstAppear = true
    let viewModel: VM

    init(viewModel: VM) {
        let store = viewModel.makeStore()
        let view = View(store: store)
        self.store = store
        self.viewModel = viewModel
        super.init(rootView: view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        store?.viewDidLoad.send()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store?.viewWillAppear.send()
        if isFirstAppear {
            isFirstAppear = false
            store?.viewWillAppearForTheFirstTime.send()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store?.viewDidAppear.send()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store?.viewWillDisappear.send()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store?.viewDidDisappear.send()
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
