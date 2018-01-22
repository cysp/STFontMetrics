//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

import UIKit


class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var stackView: UIStackView!

    @IBOutlet var title1UIFontMetricsLabel: UILabel?
    @IBOutlet var title1STFontMetricsLabel: UILabel?

    @IBOutlet var title2UIFontMetricsLabel: UILabel?
    @IBOutlet var title2STFontMetricsLabel: UILabel?

    @IBOutlet var title3UIFontMetricsLabel: UILabel?
    @IBOutlet var title3STFontMetricsLabel: UILabel?

    @IBOutlet var headlineUIFontMetricsLabel: UILabel?
    @IBOutlet var headlineSTFontMetricsLabel: UILabel?

    @IBOutlet var subheadlineUIFontMetricsLabel: UILabel?
    @IBOutlet var subheadlineSTFontMetricsLabel: UILabel?

    @IBOutlet var bodyUIFontMetricsLabel: UILabel?
    @IBOutlet var bodySTFontMetricsLabel: UILabel?

    @IBOutlet var calloutUIFontMetricsLabel: UILabel?
    @IBOutlet var calloutSTFontMetricsLabel: UILabel?

    @IBOutlet var footnoteUIFontMetricsLabel: UILabel?
    @IBOutlet var footnoteSTFontMetricsLabel: UILabel?

    @IBOutlet var caption1UIFontMetricsLabel: UILabel?
    @IBOutlet var caption1STFontMetricsLabel: UILabel?

    @IBOutlet var caption2UIFontMetricsLabel: UILabel?
    @IBOutlet var caption2STFontMetricsLabel: UILabel?

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

        func wrapAndAddToStackView<T>(_ block: (_ view: UIView) -> T) -> T {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false

            let rv = block(view)

//            view.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
            view.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)

            view.heightAnchor.constraint(greaterThanOrEqualToConstant: 32)

            stackView.addArrangedSubview(view)

            return rv
        }

        func createLabel(addedTo view: UIView, text: String? = nil) -> UILabel {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(label)

            label.text = text

            label.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true

            label.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor).isActive = true
            label.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor).isActive = true

            label.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
            label.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)

            return label
        }

        func string(for textStyle: UIFontTextStyle) -> String {
            switch textStyle {
            case .title1:
                return "Title 1"
            case .title2:
                return "Title 2"
            case .title3:
                return "Title 3"
            case .headline:
                return "Headline"
            case .subheadline:
                return "Subheadline"
            case .body:
                return "Body"
            case .callout:
                return "Callout"
            case .footnote:
                return "Footnote"
            case .caption1:
                return "Caption 1"
            case .caption2:
                return "Caption 2"
            default:
                fatalError()
            }
        }

        func createWrappedLabelsAddedToStackView(_ textStyle: UIFontTextStyle) -> (UILabel?, UILabel?) {
            return wrapAndAddToStackView { view in
//                let defaultLabel = UILabel()
//                defaultLabel.translatesAutoresizingMaskIntoConstraints = false
//
//                defaultLabel.text = string(for: textStyle)
//
//                defaultLabel.font = UIFont.preferredFont(forTextStyle: textStyle)
//                defaultLabel.adjustsFontForContentSizeCategory = true
//
//                defaultLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)
//                defaultLabel.setContentCompressionResistancePriority(UILayoutPriorityRequired, for: .vertical)
//
//                view.addSubview(defaultLabel)
//
//                defaultLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

                let textStyleText = string(for: textStyle)

                let defaultLabel = createLabel(addedTo: view, text: textStyleText)
//                defaultLabel.translatesAutoresizingMaskIntoConstraints = false
                defaultLabel.font = UIFont.preferredFont(forTextStyle: textStyle)
                defaultLabel.adjustsFontForContentSizeCategory = true

                let uifontMetricsLabel = createLabel(addedTo: view, text: textStyleText)
                let stfontMetricsLabel = createLabel(addedTo: view, text: textStyleText)

//                uifontMetricsLabel.topAnchor.constraint(greaterThanOrEqualTo: defaultLabel.bottomAnchor).isActive = true
//                stfontMetricsLabel.topAnchor.constraint(greaterThanOrEqualTo: defaultLabel.bottomAnchor).isActive = true

                defaultLabel.textColor = UIColor.black.withAlphaComponent(0.5)
                uifontMetricsLabel.textColor = UIColor.blue.withAlphaComponent(0.3)
                stfontMetricsLabel.textColor = UIColor.orange.withAlphaComponent(0.3)

                uifontMetricsLabel.firstBaselineAnchor.constraint(equalTo: defaultLabel.firstBaselineAnchor).isActive = true
                stfontMetricsLabel.firstBaselineAnchor.constraint(equalTo: defaultLabel.firstBaselineAnchor).isActive = true

                return (uifontMetricsLabel, stfontMetricsLabel)
            }
        }

        (title1UIFontMetricsLabel, title1STFontMetricsLabel) = createWrappedLabelsAddedToStackView(.title1)
        (title2UIFontMetricsLabel, title2STFontMetricsLabel) = createWrappedLabelsAddedToStackView(.title2)
        (title3UIFontMetricsLabel, title3STFontMetricsLabel) = createWrappedLabelsAddedToStackView(.title3)
        (headlineUIFontMetricsLabel, headlineSTFontMetricsLabel) = createWrappedLabelsAddedToStackView(.headline)
        (subheadlineUIFontMetricsLabel, subheadlineSTFontMetricsLabel) = createWrappedLabelsAddedToStackView(.subheadline)
        (bodyUIFontMetricsLabel, bodySTFontMetricsLabel) = createWrappedLabelsAddedToStackView(.body)
        (calloutUIFontMetricsLabel, calloutSTFontMetricsLabel) = createWrappedLabelsAddedToStackView(.callout)
        (footnoteUIFontMetricsLabel, footnoteSTFontMetricsLabel) = createWrappedLabelsAddedToStackView(.footnote)
        (caption1UIFontMetricsLabel, caption1STFontMetricsLabel) = createWrappedLabelsAddedToStackView(.caption1)
        (caption2UIFontMetricsLabel, caption2STFontMetricsLabel) = createWrappedLabelsAddedToStackView(.caption2)

        configureView()
        configureViewDebugging()
    }


//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//
//        configureView()
//    }

    func papyrusBaseFontPointSize(for textStyle: UIFontTextStyle) -> CGFloat {
        switch textStyle {
        case .title1:
            return 28
        case .title2:
            return 22
        case .title3:
            return 20
        case .headline:
            return 17
        case .subheadline:
            return 15
        case .body:
            return 17
        case .callout:
            return 16
        case .footnote:
            return 13
        case .caption1:
            return 12
        case .caption2:
            return 11
        default:
            fatalError()
        }
    }
    func papyrusBaseFont(for textStyle: UIFontTextStyle) -> UIFont {
        return UIFont(name: "Papyrus", size: papyrusBaseFontPointSize(for: textStyle))!
    }

    func sanfranciscoBaseFont(for textStyle: UIFontTextStyle) -> UIFont {
        do {
            var pointSize: CGFloat? = nil
            switch textStyle {
            case .title1:
                pointSize = 28
            case .title2:
                pointSize = 22
            case .title3:
                pointSize = 20
            default:
                break
            }
            if let pointSize = pointSize {
                return UIFont.systemFont(ofSize: pointSize)

//                let fontDescriptor = UIFont.systemFont(ofSize: UIFont.systemFontSize).fontDescriptor.addingAttributes([
//                    UIFontDescriptorTraitsAttribute: [
//                        UIFontWeightTrait: UIFontWeightRegular,
//                        UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitUIOptimized.rawValue,
//                    ],
//                ])

//                let fontDescriptor = UIFontDescriptor(fontAttributes: [
//                    UIFontDescriptorTraitsAttribute: [
//                        UIFontWeightTrait: UIFontWeightRegular,
//                        UIFontSymbolicTrait: UIFontDescriptorSymbolicTraits.traitUIOptimized.rawValue,
//                    ],
//                ])
//                return UIFont(descriptor: fontDescriptor, size: pointSize)
            }
        }

        do {
            var weight: UIFontWeight = UIFontWeightRegular
            var pointSize: CGFloat?
            switch textStyle {
            case .headline:
                pointSize = 17
                weight = UIFontWeightSemibold
            case .subheadline:
                pointSize = 15
            case .body:
                pointSize = 17
            case .callout:
                pointSize = 16
            case .footnote:
                pointSize = 13
            case .caption1:
                pointSize = 12
            case .caption2:
                pointSize = 11
            default:
                break
            }
            if let pointSize = pointSize {
                return UIFont.systemFont(ofSize: pointSize, weight: weight)

//                let fontDescriptor = UIFont.systemFont(ofSize: UIFont.systemFontSize).fontDescriptor.addingAttributes([
//                    UIFontDescriptorTraitsAttribute: [
//                        UIFontWeightTrait: weight,
//                    ],
//                ])
//                return UIFont(descriptor: fontDescriptor, size: pointSize)
            }
        }

        fatalError()
    }

    func configureLabels(for textStyle: UIFontTextStyle, _ uilabel: UILabel?, _ stlabel: UILabel?) {
        let font = papyrusBaseFont(for: textStyle)
//        let font = sanfranciscoBaseFont(for: textStyle)

        let stm = STFontMetrics(forTextStyle: .body)

        stlabel?.font = stm.scaledFont(for: font)

        if #available(iOS 11.0, *) {
            let uim = UIFontMetrics(forTextStyle: .body)
            uilabel?.font = uim.scaledFont(for: font)
        } else {
            uilabel?.isHidden = true
        }
    }

    func configureView() {
        configureLabels(for: .title1, title1UIFontMetricsLabel, title1STFontMetricsLabel)
        configureLabels(for: .title2, title2UIFontMetricsLabel, title2STFontMetricsLabel)
        configureLabels(for: .title3, title3UIFontMetricsLabel, title3STFontMetricsLabel)
        configureLabels(for: .headline, headlineUIFontMetricsLabel, headlineSTFontMetricsLabel)
        configureLabels(for: .subheadline, subheadlineUIFontMetricsLabel, subheadlineSTFontMetricsLabel)
        configureLabels(for: .body, bodyUIFontMetricsLabel, bodySTFontMetricsLabel)
        configureLabels(for: .callout, calloutUIFontMetricsLabel, calloutSTFontMetricsLabel)
        configureLabels(for: .footnote, footnoteUIFontMetricsLabel, footnoteSTFontMetricsLabel)
        configureLabels(for: .caption1, caption1UIFontMetricsLabel, caption1STFontMetricsLabel)
        configureLabels(for: .caption2, caption2UIFontMetricsLabel, caption2STFontMetricsLabel)
    }

    func configureViewDebugging() {
//        let preferredFont = UIFont.preferredFont(forTextStyle: .body)
//        let defaultFont = defaultLabel?.font
//        let stscaledFont = stfontmetricsLabel?.font
//        let uiscaledFont = uifontmetricsLabel?.font
//
//        debugLabel?.text = [
//            "p: \(preferredFont.fontName) \(preferredFont.pointSize)",
//            "d: \(defaultFont?.fontName ?? "???") \(defaultFont?.pointSize ?? 0)",
//            "s: \(stscaledFont?.fontName ?? "???") \(stscaledFont?.pointSize ?? 0)",
//            "u: \(uiscaledFont?.fontName ?? "???") \(uiscaledFont?.pointSize ?? 0)",
//        ].joined(separator: "\n")
    }
}
