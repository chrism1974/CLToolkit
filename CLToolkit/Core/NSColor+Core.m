//
//  Color+Core.m
//  Collections
//
//  Created by Tony Xiao on 3/10/13.
//  Copyright (c) 2013 Collections Labs, Inc. All rights reserved.
//

#import "NSColor+Core.h"

@implementation COLOR_CLASS (Core)

+ (COLOR_CLASS *)colorWithHexColorString:(NSString *)inColorString {
    COLOR_CLASS *result = nil;
    unsigned colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString) {
        NSScanner* scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char)(colorCode >> 16);
    greenByte = (unsigned char)(colorCode >> 8);
    blueByte = (unsigned char)(colorCode); // masks off high bits

#if TARGETING_MAC
    result = [COLOR_CLASS colorWithCalibratedRed:(CGFloat)redByte / 0xff
                                           green:(CGFloat)greenByte / 0xff
                                            blue:(CGFloat)blueByte / 0xff
                                           alpha:1.0];
#else
    result = [COLOR_CLASS colorWithRed:(CGFloat)redByte / 0xff
                                 green:(CGFloat)greenByte / 0xff
                                  blue:(CGFloat)blueByte / 0xff
                                 alpha:1.0];
#endif
    return result;
}

@end
