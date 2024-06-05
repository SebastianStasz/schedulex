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

    override open func viewDidLoad() {
        super.viewDidLoad()
        let view = View(store: store)
        displayView(view)
        store.viewDidLoad.send()
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.viewWillAppear.send()
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        store.viewDidAppear.send()
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        store.viewWillDisappear.send()
    }

    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.viewDidDisappear.send()
    }

    @available(*, unavailable)
    @MainActor public dynamic required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
