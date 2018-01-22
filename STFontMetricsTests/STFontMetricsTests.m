//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright © 2017 Scott Talbot.

#import <XCTest/XCTest.h>

#import "STFontMetrics.h"
#import "STFontMetrics+Internal.h"
#import "UIApplication+STFontMetricsTests.h"


@interface STFontMetricsTests : XCTestCase
@end

@implementation STFontMetricsTests

- (void)testDefaultContentSizeCategory {
    UIContentSizeCategory const ui = UIApplication._defaultContentSizeCategory;
    UIContentSizeCategory const st = STFontMetricsDefaultContentSizeCategory();

    XCTAssertEqualObjects(ui, st);
}

@end
