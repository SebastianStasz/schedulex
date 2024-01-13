//
//  SwiftUIViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine
import SwiftUI

class SwiftUIViewController<VM: ViewModel, View: RootView>: UIViewController where VM.Store == View.Store {
    private lazy var store = viewModel.makeStore(context: coreEnvironment.context)
    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let view = View(store: store)
        displayView(view)
        store.viewDidLoad.send()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.viewWillAppear.send()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.viewDidAppear.send()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.viewWillDisappear.send()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.viewDidDisappear.send()
    }

    @available(*, unavailable)
    @MainActor dynamic required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
