//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

#import <XCTest/XCTest.h>

#import "STFontMetrics.h"


@interface STFontMetricsScaledValueTests : XCTestCase
@end

@implementation STFontMetricsScaledValueTests

//#define X(ts) \
//- (void)testNoop##ts { \
//    [self st_testNoopWithTextStyle:UIFontTextStyle##ts];\
//}
//
////X(UIFontTextStyleLargeTitle)
//X(Title1)
//X(Title2)
//X(Title3)
//X(Headline)
//X(Subheadline)
//X(Body)
//X(Callout)
//X(Footnote)
//X(Caption1)
//X(Caption2)
//
//#undef X

#define X(ts, csc) \
- (void)testScaledValues##ts##csc { \
    [self st_testScaledValuesWithTextStyle:UIFontTextStyle##ts contentSizeCategory:UIContentSizeCategory##csc]; \
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


#define X(csc, ts, v, ev) \
- (void)testScaledValue##csc##ts##_##v { \
    [self st_testContentSizeCategory:UIContentSizeCategory##csc textStyle:UIFontTextStyle##ts value:v expectedValue:ev]; \
}

X(Medium, Body, 40, 38+1./3.)
X(Large, Body, 40, 40)

#undef X


//- (void)st_testNoopWithTextStyle:(UIFontTextStyle)textStyle {
//    UIContentSizeCategory contentSizeCategory;
//
//    NSOperatingSystemVersion const operatingSystemVersion = NSProcessInfo.processInfo.operatingSystemVersion;
//    switch (operatingSystemVersion.majorVersion) {
//        case 9 ... 10:
//            contentSizeCategory = UIContentSizeCategoryMedium;
//            break;
//        default:
//            contentSizeCategory = UIContentSizeCategoryLarge;
//            break;
//    }
//
//    for (NSUInteger value = 0; value < 144; ++value) {
//        [self st_testScaledValue:value withTextStyle:textStyle contentSizeCategory:contentSizeCategory noop:YES];
//    }
//}

- (void)st_testScaledValuesWithTextStyle:(UIFontTextStyle)textStyle contentSizeCategory:(UIContentSizeCategory)contentSizeCategory {
    for (NSUInteger value = 0; value < 144; ++value) {
        [self st_testScaledValue:value withTextStyle:textStyle contentSizeCategory:contentSizeCategory noop:NO];
    }
}

- (void)st_testScaledValue:(CGFloat)value withTextStyle:(UIFontTextStyle)textStyle contentSizeCategory:(UIContentSizeCategory)contentSizeCategory noop:(BOOL)noop {
    UITraitCollection *traits;
#if __has_builtin(__builtin_available)
    if (@available(iOS 10, *)) {
#else
    if ([UITraitCollection respondsToSelector:@selector(traitCollectionWithPreferredContentSizeCategory:)]) {
#endif
        traits = [UITraitCollection traitCollectionWithPreferredContentSizeCategory:contentSizeCategory];
    }

    STFontMetrics * const metrics = [STFontMetrics metricsForTextStyle:textStyle];
    CGFloat const scaledValue = [metrics scaledValueForValue:value compatibleWithTraitCollection:traits];

    if (noop) {
        XCTAssertEqual(scaledValue, value, @"csc: %@, ts: %@", contentSizeCategory, textStyle);
    }

#if __has_builtin(__builtin_available)
    if (@available(iOS 11, *)) {
        UIFontMetrics * const uiMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
        CGFloat const uiScaledValue = [uiMetrics scaledValueForValue:value compatibleWithTraitCollection:traits];

        XCTAssertEqual(scaledValue, uiScaledValue);
    }
#endif
}

- (void)st_testContentSizeCategory:(UIContentSizeCategory)contentSizeCategory textStyle:(UIFontTextStyle)textStyle value:(CGFloat)value expectedValue:(CGFloat)expectedValue {
    UITraitCollection *traits;
#if __has_builtin(__builtin_available)
    if (@available(iOS 10, *)) {
#else
    if ([UITraitCollection respondsToSelector:@selector(traitCollectionWithPreferredContentSizeCategory:)]) {
#endif
        traits = [UITraitCollection traitCollectionWithPreferredContentSizeCategory:contentSizeCategory];
    }

    STFontMetrics * const metrics = [STFontMetrics metricsForTextStyle:textStyle];
    CGFloat const scaledValue = [metrics scaledValueForValue:value compatibleWithTraitCollection:traits];

#if __has_builtin(__builtin_available)
    if (@available(iOS 11, *)) {
        UIFontMetrics * const uiMetrics = [UIFontMetrics metricsForTextStyle:textStyle];
        CGFloat const uiScaledValue = [uiMetrics scaledValueForValue:value compatibleWithTraitCollection:traits];

        XCTAssertEqual(scaledValue, uiScaledValue);
    }
#endif

    XCTAssertEqual(scaledValue, expectedValue);
}

@end


