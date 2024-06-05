//
//  SwiftUIViewController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import Combine
import SwiftUI

open class SwiftUIViewController<VM: ViewModel, View: RootView>: UIViewController where VM.Store == View.Store {
    private lazy var store = viewModel.makeStore(context: coreEnvironment.context)
    public let viewModel: VM

    public init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        let view = View(store: store)
        displayView(view)
        store.viewDidLoad.send()
    }

    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.viewWillAppear.send()
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.viewDidAppear.send()
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.viewWillDisappear.send()
    }

    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.viewDidDisappear.send()
    }

    @available(*, unavailable)
    @MainActor public dynamic required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
