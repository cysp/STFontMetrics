//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

#import "STFontMetrics.h"


NS_ASSUME_NONNULL_BEGIN

extern CGFloat STRoundToScale(CGFloat value);
extern CGFloat STFontBodyLeading(UIFont *font);
extern BOOL STFontIsSupportedDynamicFontTextStyle(UIFontTextStyle textStyle);
extern CGFloat STFontScaledValueForValue(UIFont *font, CGFloat value);
extern CGFloat STFontPointSizeScaledLikeTextStyle(Class UIFontClass, CGFloat pointSize, UIFontTextStyle textStyle, CGFloat maximumPointSize, UITraitCollection *compatibleWithTraitCollection);

NS_ASSUME_NONNULL_END
