//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

#import "STFontMetrics.h"
#import "STFontMetrics+Internal.h"


CGFloat STRoundToScale(CGFloat value) {
    static CGFloat mainScreenScale;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mainScreenScale = UIScreen.mainScreen.scale;
    });

    value *= mainScreenScale;
    value = round(value);
    value /= mainScreenScale;
    return value;
}

CGFloat STFontBodyLeading(UIFont *font) {
    return font.lineHeight + font.leading;
}

BOOL STFontIsSupportedDynamicFontTextStyle(UIFontTextStyle textStyle) {
    static NSSet<UIFontTextStyle> *supportedTextStyles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        supportedTextStyles = [[NSSet alloc] initWithObjects:
            @"UICTFontTextStyleHeadline",
            @"UICTFontTextStyleBody",
            @"UICTFontTextStyleSubhead",
            @"UICTFontTextStyleCaption1",
            @"UICTFontTextStyleCaption2",
            @"UICTFontTextStyleTitle1",
            @"UICTFontTextStyleTitle2",
            @"UICTFontTextStyleTitle3",
            @"UICTFontTextStyleTitle4",
            @"UICTFontTextStyleTitle5",
            @"UICTFontTextStyleSubtitle",
            @"UICTFontTextStyleSubtitle1",
            @"UICTFontTextStyleSubtitle2",
            @"UICTFontTextStyleSubtitle3",
            @"UICTFontTextStyleCallout",
            @"UICTFontTextStyleFootnote",
            @"UICTFontTextStyleFootnote2",
            @"UICTFontTextStyleHeadline1",
            @"UICTFontTextStyleHeadline2",
            @"UICTFontTextStyleSubhead1",
            nil];
    });
    return [supportedTextStyles containsObject:textStyle];
}

UIContentSizeCategory STFontMetricsDefaultContentSizeCategory(void) {
    UIContentSizeCategory contentSizeCategory;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
    NSOperatingSystemVersion const operatingSystemVersion = NSProcessInfo.processInfo.operatingSystemVersion;
    switch (operatingSystemVersion.majorVersion) {
        case 9 ... 10:
            contentSizeCategory = UIContentSizeCategoryMedium;
            break;
        default:
            contentSizeCategory = UIContentSizeCategoryLarge;
            break;
    }
#else
    contentSizeCategory = UIContentSizeCategoryLarge;
#endif
    return contentSizeCategory;
}

CGFloat STFontScaledValueForValue(UIFont *font, CGFloat value) {
    UIFontDescriptor * const fontDescriptor = font.fontDescriptor;
    UIFontTextStyle const fontTextStyle = fontDescriptor.fontAttributes[UIFontDescriptorTextStyleAttribute];
    if (!fontTextStyle) {
        return value;
    }

    CGFloat const fontBodyLeading = STFontBodyLeading(font);

    UIFont *preferredFont;
    UIContentSizeCategory const contentSizeCategory = STFontMetricsDefaultContentSizeCategory();

#if __has_builtin(__builtin_available)
    if (@available(iOS 10, *)) {
#else
    if ([UIFont respondsToSelector:@selector(preferredFontForTextStyle:compatibleWithTraitCollection:)]) {
#endif
        UITraitCollection * const traitCollection = [UITraitCollection traitCollectionWithPreferredContentSizeCategory:contentSizeCategory];
        preferredFont = [UIFont preferredFontForTextStyle:fontTextStyle compatibleWithTraitCollection:traitCollection];
    }
    if (!preferredFont) {
        preferredFont = [UIFont preferredFontForTextStyle:fontTextStyle];
    }
    CGFloat const preferredFontBodyLeading = STFontBodyLeading(preferredFont);

    return ((fontBodyLeading * value) / preferredFontBodyLeading);
}

CGFloat STFontPointSizeScaledLikeTextStyle(Class UIFontClass, CGFloat pointSize, UIFontTextStyle textStyle, CGFloat maximumPointSize, UITraitCollection *traitCollection) {
    UIFont *preferredFont;
#if __has_builtin(__builtin_available)
    if (@available(iOS 10, *)) {
#else
    if ([UIFont respondsToSelector:@selector(preferredFontForTextStyle:compatibleWithTraitCollection:)]) {
#endif
        preferredFont = [UIFont preferredFontForTextStyle:textStyle compatibleWithTraitCollection:traitCollection];
    }
    if (!preferredFont) {
        preferredFont = [UIFont preferredFontForTextStyle:textStyle];
    }

    CGFloat const scaledPointSize = round(STFontScaledValueForValue(preferredFont, pointSize));
    return MIN(scaledPointSize, maximumPointSize);
}


@implementation STFontMetrics {
@private
    UIFontTextStyle _textStyle;
}

+ (STFontMetrics *)defaultMetrics {
    return [[self alloc] initForTextStyle:UIFontTextStyleBody];
}

+ (instancetype)metricsForTextStyle:(UIFontTextStyle)textStyle {
    return [[self alloc] initForTextStyle:textStyle];
}

- (instancetype)initForTextStyle:(UIFontTextStyle)textStyle {
    if ((self = [super init])) {
        _textStyle = textStyle.copy;
    }
    return self;
}

- (UIFont *)scaledFontForFont:(UIFont *)font {
    return [self scaledFontForFont:font maximumPointSize:INFINITY];
}
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximumPointSize {
    return [self scaledFontForFont:font maximumPointSize:maximumPointSize compatibleWithTraitCollection:nil];
}
- (UIFont *)scaledFontForFont:(UIFont *)font compatibleWithTraitCollection:(nullable UITraitCollection *)traitCollection {
    return [self scaledFontForFont:font maximumPointSize:INFINITY compatibleWithTraitCollection:traitCollection];
}
- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximumPointSize compatibleWithTraitCollection:(nullable UITraitCollection *)traitCollection {
    NSParameterAssert(font);
    if (!font) {
        return nil;
    }

    UIFontDescriptor * const fontDescriptor = font.fontDescriptor;
    UIFontTextStyle const fontTextStyle = fontDescriptor.fontAttributes[UIFontDescriptorTextStyleAttribute];
    if (fontTextStyle && STFontIsSupportedDynamicFontTextStyle(fontTextStyle)) {
        UIFont *scaledFont;
#if __has_builtin(__builtin_available)
        if (@available(iOS 10, *)) {
#else
        if ([UIFont respondsToSelector:@selector(preferredFontForTextStyle:compatibleWithTraitCollection:)]) {
#endif
            scaledFont = [UIFont preferredFontForTextStyle:fontTextStyle compatibleWithTraitCollection:traitCollection];
        }
        if (!scaledFont) {
            scaledFont = [UIFont preferredFontForTextStyle:fontTextStyle];
        }
        return scaledFont;
    }

    CGFloat const pointSize = STFontPointSizeScaledLikeTextStyle(font.class, font.pointSize, _textStyle, maximumPointSize, traitCollection);
    return [UIFont fontWithDescriptor:fontDescriptor size:pointSize];
}

- (CGFloat)scaledValueForValue:(CGFloat)value {
    return [self scaledValueForValue:value compatibleWithTraitCollection:nil];
}
- (CGFloat)scaledValueForValue:(CGFloat)value compatibleWithTraitCollection:(nullable UITraitCollection *)traitCollection {
    UIFont *font;
#if __has_builtin(__builtin_available)
    if (@available(iOS 10.0, *)) {
        font = [UIFont preferredFontForTextStyle:_textStyle compatibleWithTraitCollection:traitCollection];
        NSAssert(font, @"");
    }
#endif
    if (!font) {
        font = [UIFont preferredFontForTextStyle:_textStyle];
    }
    if (!font) {
        return value;
    }

    return STRoundToScale(STFontScaledValueForValue(font, value));
}

@end
