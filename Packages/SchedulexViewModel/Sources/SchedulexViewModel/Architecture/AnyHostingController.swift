//
//  AnyHostingController.swift
//  Schedulex
//
//  Created by Sebastian Staszczyk on 13/01/2024.
//

import SwiftUI

final class AnyHostingController: UIViewController {
    private let hostingController: UIViewController

    init(rootView: some View) {
        hostingController = RestrictedHostingController(rootView: rootView)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
//        hostingController.view.backgroundColor = .clear

        display(hostingController) { view in
            guard let superview = view.superview else { return }
            view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([view.topAnchor.constraint(equalTo: superview.topAnchor),
                                         view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
                                         view.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
                                         view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)])
        }
    }
}

final class RestrictedHostingController<Content: View>: UIHostingController<Content> {
    /// The hosting controller may in some cases want to make the navigation bar be not hidden.
    /// Restrict the access to the outside world, by setting the navigation controller to nil when internally accessed.
    override public var navigationController: UINavigationController? {
        nil
    }
}
