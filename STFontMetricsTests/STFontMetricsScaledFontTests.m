//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

#import <XCTest/XCTest.h>

#import "STFontMetrics.h"


@interface STFontMetricsScaledFontTests : XCTestCase
@end

@implementation STFontMetricsScaledFontTests

#define X(ts) \
- (void)testNoop##ts { \
    UIContentSizeCategory contentSizeCategory; \
    NSOperatingSystemVersion const operatingSystemVersion = NSProcessInfo.processInfo.operatingSystemVersion; \
    switch (operatingSystemVersion.majorVersion) { \
        case 9 ... 10: \
            contentSizeCategory = UIContentSizeCategoryMedium; \
            break; \
        default: \
            contentSizeCategory = UIContentSizeCategoryLarge; \
            break; \
    } \
    for (NSUInteger pointSize = 0; pointSize <= 144; ++pointSize) { \
        [self st_testScaledFontWithInitialPointSize:pointSize textStyle:UIFontTextStyle##ts contentSizeCategory:contentSizeCategory noop:YES]; \
    } \
}

//X(UIFontTextStyleLargeTitle)
X(Title1)
X(Title2)
X(Title3)
X(Headline)
X(Subheadline)
X(Body)
X(Callout)
X(Footnote)
X(Caption1)
X(Caption2)

#undef X


#define X(ts, csc) \
- (void)testScaledFont##ts##csc { \
    NSArray<UIFontTextStyle> * const textStyles = @[ \
        UIFontTextStyleTitle1, \
        UIFontTextStyleTitle2, \
        UIFontTextStyleTitle3, \
        UIFontTextStyleHeadline, \
        UIFontTextStyleSubheadline, \
        UIFontTextStyleBody, \
        UIFontTextStyleCallout, \
        UIFontTextStyleFootnote, \
        UIFontTextStyleCaption1, \
        UIFontTextStyleCaption2, \
    ]; \
    UIFontTextStyle const textStyle = UIFontTextStyle##ts; \
    UIContentSizeCategory const contentSizeCategory = UIContentSizeCategory##csc; \
    for (UIFontTextStyle initialTextStyle in textStyles) { \
        [self st_testScaledFontWithInitialTextStyle:initialTextStyle textStyle:textStyle contentSizeCategory:contentSizeCategory noop:NO]; \
    } \
    for (NSUInteger initialPointSize = 0; initialPointSize <= 144; ++initialPointSize) { \
        [self st_testScaledFontWithInitialPointSize:initialPointSize textStyle:textStyle contentSizeCategory:contentSizeCategory noop:NO]; \
    } \
}

X(Title1, ExtraSmall)
X(Title1, Small)
X(Title1, Medium)
X(Title1, Large)
X(Title1, ExtraLarge)
X(Title1, ExtraExtraLarge)
X(Title1, ExtraExtraExtraLarge)
X(Title1, AccessibilityMedium)
X(Title1, AccessibilityLarge)
X(Title1, AccessibilityExtraLarge)
X(Title1, AccessibilityExtraExtraLarge)
X(Title1, AccessibilityExtraExtraExtraLarge)
X(Title2, ExtraSmall)
X(Title2, Small)
X(Title2, Medium)
X(Title2, Large)
X(Title2, ExtraLarge)
X(Title2, ExtraExtraLarge)
X(Title2, ExtraExtraExtraLarge)
X(Title2, AccessibilityMedium)
X(Title2, AccessibilityLarge)
X(Title2, AccessibilityExtraLarge)
X(Title2, AccessibilityExtraExtraLarge)
X(Title2, AccessibilityExtraExtraExtraLarge)
X(Title3, ExtraSmall)
X(Title3, Small)
X(Title3, Medium)
X(Title3, Large)
X(Title3, ExtraLarge)
X(Title3, ExtraExtraLarge)
X(Title3, ExtraExtraExtraLarge)
X(Title3, AccessibilityMedium)
X(Title3, AccessibilityLarge)
X(Title3, AccessibilityExtraLarge)
X(Title3, AccessibilityExtraExtraLarge)
X(Title3, AccessibilityExtraExtraExtraLarge)
X(Headline, ExtraSmall)
X(Headline, Small)
X(Headline, Medium)
X(Headline, Large)
X(Headline, ExtraLarge)
X(Headline, ExtraExtraLarge)
X(Headline, ExtraExtraExtraLarge)
X(Headline, AccessibilityMedium)
X(Headline, AccessibilityLarge)
X(Headline, AccessibilityExtraLarge)
X(Headline, AccessibilityExtraExtraLarge)
X(Headline, AccessibilityExtraExtraExtraLarge)
X(Subheadline, ExtraSmall)
X(Subheadline, Small)
X(Subheadline, Medium)
X(Subheadline, Large)
X(Subheadline, ExtraLarge)
X(Subheadline, ExtraExtraLarge)
X(Subheadline, ExtraExtraExtraLarge)
X(Subheadline, AccessibilityMedium)
X(Subheadline, AccessibilityLarge)
X(Subheadline, AccessibilityExtraLarge)
X(Subheadline, AccessibilityExtraExtraLarge)
X(Subheadline, AccessibilityExtraExtraExtraLarge)
X(Body, ExtraSmall)
X(Body, Small)
X(Body, Medium)
X(Body, Large)
X(Body, ExtraLarge)
X(Body, ExtraExtraLarge)
X(Body, ExtraExtraExtraLarge)
X(Body, AccessibilityMedium)
X(Body, AccessibilityLarge)
X(Body, AccessibilityExtraLarge)
X(Body, AccessibilityExtraExtraLarge)
X(Body, AccessibilityExtraExtraExtraLarge)
X(Callout, ExtraSmall)
X(Callout, Small)
X(Callout, Medium)
X(Callout, Large)
X(Callout, ExtraLarge)
X(Callout, ExtraExtraLarge)
X(Callout, ExtraExtraExtraLarge)
X(Callout, AccessibilityMedium)
X(Callout, AccessibilityLarge)
X(Callout, AccessibilityExtraLarge)
X(Callout, AccessibilityExtraExtraLarge)
X(Callout, AccessibilityExtraExtraExtraLarge)
X(Footnote, ExtraSmall)
X(Footnote, Small)
X(Footnote, Medium)
X(Footnote, Large)
X(Footnote, ExtraLarge)
X(Footnote, ExtraExtraLarge)
X(Footnote, ExtraExtraExtraLarge)
X(Footnote, AccessibilityMedium)
X(Footnote, AccessibilityLarge)
X(Footnote, AccessibilityExtraLarge)
X(Footnote, AccessibilityExtraExtraLarge)
X(Footnote, AccessibilityExtraExtraExtraLarge)
X(Caption1, ExtraSmall)
X(Caption1, Small)
X(Caption1, Medium)
X(Caption1, Large)
X(Caption1, ExtraLarge)
X(Caption1, ExtraExtraLarge)
X(Caption1, ExtraExtraExtraLarge)
X(Caption1, AccessibilityMedium)
X(Caption1, AccessibilityLarge)
X(Caption1, AccessibilityExtraLarge)
X(Caption1, AccessibilityExtraExtraLarge)
X(Caption1, AccessibilityExtraExtraExtraLarge)
X(Caption2, ExtraSmall)
X(Caption2, Small)
X(Caption2, Medium)
X(Caption2, Large)
X(Caption2, ExtraLarge)
X(Caption2, ExtraExtraLarge)
X(Caption2, ExtraExtraExtraLarge)
X(Caption2, AccessibilityMedium)
X(Caption2, AccessibilityLarge)
X(Caption2, AccessibilityExtraLarge)
X(Caption2, AccessibilityExtraExtraLarge)
X(Caption2, AccessibilityExtraExtraExtraLarge)

#undef X


- (void)st_testScaledFontWithInitialTextStyle:(UIFontTextStyle)initialTextStyle textStyle:(UIFontTextStyle)textStyle contentSizeCategory:(UIContentSizeCategory)contentSizeCategory noop:(BOOL)noop {
    UIFont * const font = [UIFont preferredFontForTextStyle:initialTextStyle];
    [self st_testScaledFontWithInitialFont:font textStyle:textStyle contentSizeCategory:contentSizeCategory noop:noop];
}

- (void)st_testScaledFontWithInitialPointSize:(CGFloat)pointSize textStyle:(UIFontTextStyle)textStyle contentSizeCategory:(UIContentSizeCategory)contentSizeCategory noop:(BOOL)noop {
    UIFont * const font = [UIFont fontWithName:@"Papyrus" size:pointSize];
    [self st_testScaledFontWithInitialFont:font textStyle:textStyle contentSizeCategory:contentSizeCategory noop:noop];
}

- (void)st_testScaledFontWithInitialFont:(UIFont *)font textStyle:(UIFontTextStyle)textStyle contentSizeCategory:(UIContentSizeCategory)contentSizeCategory noop:(BOOL)noop {
    UITraitCollection *traits;
#if __has_builtin(__builtin_available)
    if (@available(iOS 10, *)) {
#else
    if ([UITraitCollection respondsToSelector:@selector(traitCollectionWithPreferredContentSizeCategory:)]) {
#endif
        traits = [UITraitCollection traitCollectionWithPreferredContentSizeCategory:contentSizeCategory];
    }

    STFontMetrics * const metrics = [STFontMetrics metricsForTextStyle:textStyle];
    UIFont * const scaledFont = [metrics scaledFontForFont:font compatibleWithTraitCollection:traits];

    if (noop) {
        XCTAssertEqualObjects(scaledFont, font, @"initialPointSize: %f", font.pointSize);
        XCTAssertEqual(scaledFont.pointSize, font.pointSize, @"initialPointSize: %f", font.pointSize);
    }

#if __has_builtin(__builtin_available)
    if (@available(iOS 11, *)) {
        UIFontMetrics * const uiMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
        UIFont * const uiScaledFont = [uiMetrics scaledFontForFont:font compatibleWithTraitCollection:traits];

        XCTAssertEqualObjects(scaledFont, uiScaledFont, @"initialPointSize: %f", font.pointSize);
        XCTAssertEqual(scaledFont.pointSize, uiScaledFont.pointSize, @"initialPointSize: %f", font.pointSize);
    }
#endif
}

@end
