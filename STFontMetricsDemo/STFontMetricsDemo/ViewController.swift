//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

import UIKit


class ViewController: UIViewController {

    @IBOutlet var defaultLabel: UILabel?
    @IBOutlet var stfontmetricsLabel: UILabel?
    @IBOutlet var uifontmetricsLabel: UILabel?

    @IBOutlet var debugLabel: UILabel?

    var observation: AnyObject?

    override func awakeFromNib() {
        super.awakeFromNib()

        observation = NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: nil, queue: nil, using: { [weak self] note in
                self?.configureView()
            DispatchQueue.main.asyncAfter(wallDeadline: DispatchWallTime.now() + 0.01) {
                [weak self] _ in
                self?.configureViewDebugging()
            }
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureViewDebugging()
    }


//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//
//        configureView()
//    }

    func configureView() {
        let font = UIFont(name: "Papyrus", size: 17)!
//        let font = UIFont(descriptor: fontDescriptor.addingAttributes([
//            UIFontDescriptorTextStyleAttribute: UIFontTextStyle.body,
//        ]), size: 17)
//        let font = UIFont(descriptor: UIFont.systemFont(ofSize: 17).fontDescriptor.addingAttributes([
//            UIFontDescriptorTextStyleAttribute: UIFontTextStyle.body,
//        ]), size: 17)
        let stm = STFontMetrics(forTextStyle: .body)
        stfontmetricsLabel?.font = stm.scaledFont(for: font)
        if #available(iOS 11.0, *) {
            let uim = UIFontMetrics(forTextStyle: .body)
            uifontmetricsLabel?.font = uim.scaledFont(for: font)
        } else {
            uifontmetricsLabel?.isHidden = true
        }
    }

    func configureViewDebugging() {
        let preferredFont = UIFont.preferredFont(forTextStyle: .body)
        let defaultFont = defaultLabel?.font
        let stscaledFont = stfontmetricsLabel?.font
        let uiscaledFont = uifontmetricsLabel?.font

        debugLabel?.text = [
            "p: \(preferredFont.fontName) \(preferredFont.pointSize)",
            "d: \(defaultFont?.fontName ?? "???") \(defaultFont?.pointSize ?? 0)",
            "s: \(stscaledFont?.fontName ?? "???") \(stscaledFont?.pointSize ?? 0)",
            "u: \(uiscaledFont?.fontName ?? "???") \(uiscaledFont?.pointSize ?? 0)",
        ].joined(separator: "\n")
    }
}
