//
//  UILabel+Click.m
//  FriendCircle
//
//  Created by xgf on 2018/8/16.
//  Copyright © 2018年 HuaZhongShiXun. All rights reserved.
//

#import "UILabel+Click.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>
#import "UIView+YXAction.h"

#define kFont14 [UIFont systemFontOfSize:14]

static NSString *UILabelClickRangeMapperKey = @"UILabelClickRangeMapperKey";

@implementation UILabel (Click)

/**
 * 处理UILabel的text的某个range的点击事件
 * clickRange UILabel的text的响应点击事件的范围
 * handler 点击给定范围内的字符串的回调
 */
- (void)clickAtRange:(NSRange)clickRange handler:(void(^)(UILabel *, UITapGestureRecognizer *))handler {
    NSMutableDictionary *mapper = objc_getAssociatedObject(self, &UILabelClickRangeMapperKey);
    if(!mapper) {
        mapper = [NSMutableDictionary dictionary];
    }
    [mapper setValue:handler forKey:NSStringFromRange(clickRange)];
    objc_setAssociatedObject(self, &UILabelClickRangeMapperKey, mapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak typeof(self) wkself = self;
    [self addTapAction:^(UITapGestureRecognizer *sender) {
        [wkself handleClick:sender];
        //[wkself handleClickAction:sender clickRange:clickRange clickHandler:handler];
    }];
}

- (void)clearHandler {
    objc_setAssociatedObject(self, &UILabelClickRangeMapperKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)handleClick:(UITapGestureRecognizer *)sender {
        NSString *content = self.text;
        NSAttributedString *attributedText = self.attributedText;
        if(!content || content.length ==0 || !attributedText || attributedText.length == 0) {
            return;
        }
        sender.enabled = NO;
        CGPoint point = [sender locationInView:sender.view];
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
        CGMutablePathRef Path = CGPathCreateMutable();
        CGPathAddRect(Path, NULL, self.bounds);
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if (attributedText.length > range.length) {
            UIFont *font = kFont14;
            CGPathRelease(Path);
            Path = CGPathCreateMutable();
            CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
        }
        CFArrayRef lines = CTFrameGetLines(frame);
        if (!lines) {
            CFRelease(frame);
            CFRelease(framesetter);
            CGPathRelease(Path);
            sender.enabled = YES;
            return;
        }
        CFIndex count = CFArrayGetCount(lines);
        CGPoint origins[count];
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
        CGAffineTransform transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
        CGFloat verticalOffset = 0;
        for (CFIndex i = 0; i < count; i++) {
            CGPoint linePoint = origins[i];
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            CGFloat flushFactor = [self getFlushFactor];
            CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flushFactor, self.bounds.size.width);
            linePoint.x = penOffset;//考虑文本对齐方式对点击文本位置的影响
            CGFloat ascent = 0.0f;
            CGFloat descent = 0.0f;
            CGFloat leading = 0.0f;
            CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGFloat height = ascent + fabs(descent) + leading;
            CGRect flippedRect = CGRectMake(linePoint.x, linePoint.y , width, height);
            CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
            rect = CGRectInset(rect, 0, 0);
            rect = CGRectOffset(rect, 0, verticalOffset);
            NSParagraphStyle *style = [attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
            CGFloat lineSpace;
            if (style) {
                lineSpace = style.lineSpacing;
            }else {
                lineSpace = 0;
            }
            CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
            rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
            if (CGRectContainsPoint(rect, point)) {
                CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
                CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
                CGFloat offset;
                CTLineGetOffsetForStringIndex(line, index, &offset);
                if (offset > relativePoint.x) {
                    index = index - 1;
                }
                NSMutableDictionary *mapper = objc_getAssociatedObject(self, &UILabelClickRangeMapperKey);
                __block BOOL containsInClickRange = NO;
                __block void(^handler)(UILabel *, UITapGestureRecognizer *);
                if(mapper) {
                    [mapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        NSString *rangeKey = key;
                        NSRange targetRange = NSRangeFromString(rangeKey);
                        if(targetRange.location + targetRange.length > content.length) {
                            targetRange = NSMakeRange(targetRange.location, content.length - targetRange.location);
                        }
                        if(NSLocationInRange(index, targetRange)) {
                            containsInClickRange = YES;
                            handler = mapper[rangeKey];
                        }
                    }];
                }
                if(containsInClickRange) {
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    sender.enabled = YES;
                    if(handler) {
                        handler(self, sender);
                    }
                    return;
                }
            }
        }
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        sender.enabled = YES;
}

- (CGFloat)getFlushFactor {
    NSTextAlignment alignment = self.textAlignment;
    if(alignment == NSTextAlignmentCenter) {
        return 0.5;
    } else if(alignment == NSTextAlignmentRight) {
        return 1.0;
    } else {
        return 0;
    }
}


/**
 * 处理UILabel的text的某个range的点击事件
 * clickRange UILabel的text的响应点击事件的范围
 * handler 点击给定范围内的字符串的回调
 */
- (void)handleClickAction:(UITapGestureRecognizer *)sender clickRange:(NSRange)clickRange clickHandler:(void(^)(UILabel *, UITapGestureRecognizer *))handler {
    NSString *content = self.text;
    NSAttributedString *attributedText = self.attributedText;
    if(!content || content.length ==0 || !attributedText || attributedText.length == 0 || clickRange.length == 0 || clickRange.location >= content.length) {
        return;
    }
    NSRange targetRange = clickRange;
    if(clickRange.location + clickRange.length > content.length) {
        targetRange = NSMakeRange(clickRange.location, content.length - clickRange.location);
    }
    sender.enabled = NO;
    CGPoint point = [sender locationInView:sender.view];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, self.bounds);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    CFRange range = CTFrameGetVisibleStringRange(frame);
    if (attributedText.length > range.length) {
        UIFont *font = kFont14;
        CGPathRelease(Path);
        Path = CGPathCreateMutable();
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    CFArrayRef lines = CTFrameGetLines(frame);
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        sender.enabled = YES;
        return;
    }
    CFIndex count = CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    CGAffineTransform transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
    CGFloat verticalOffset = 0;
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat ascent = 0.0f;
        CGFloat descent = 0.0f;
        CGFloat leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat height = ascent + fabs(descent) + leading;
        CGRect flippedRect = CGRectMake(linePoint.x, linePoint.y , width, height);
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        rect = CGRectInset(rect, 0, 0);
        rect = CGRectOffset(rect, 0, verticalOffset);
        NSParagraphStyle *style = [attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        CGFloat lineSpace;
        if (style) {
            lineSpace = style.lineSpacing;
        } else {
            lineSpace = 0;
        }
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        if (CGRectContainsPoint(rect, point)) {
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            CGFloat offset;
            CTLineGetOffsetForStringIndex(line, index, &offset);
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            if(NSLocationInRange(index, targetRange)) {
                CFRelease(frame);
                CFRelease(framesetter);
                CGPathRelease(Path);
                sender.enabled = YES;
                if(handler != nil) {
                    handler(self, sender);
                }
                return;
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    sender.enabled = YES;
}

@end


static NSString *UITextViewClickRangeMapperKey = @"UITextViewClickRangeMapperKey";

@implementation UITextView (Click)

- (void)clickAtRange:(NSRange)clickRange handler:(void (^)(UITextView *, UITapGestureRecognizer *))handler {
    NSMutableDictionary *mapper = objc_getAssociatedObject(self, &UITextViewClickRangeMapperKey);
    if(!mapper) {
        mapper = [NSMutableDictionary dictionary];
    }
    [mapper setValue:handler forKey:NSStringFromRange(clickRange)];
    objc_setAssociatedObject(self, &UITextViewClickRangeMapperKey, mapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    __weak typeof(self) wkself = self;
    [self addTapAction:^(UITapGestureRecognizer *sender) {
        [wkself handleClick:sender];
        //[wkself handleClickAction:sender clickRange:clickRange clickHandler:handler];
    }];
}

- (void)clearHandler {
    objc_setAssociatedObject(self, &UITextViewClickRangeMapperKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)handleClick:(UITapGestureRecognizer *)sender {
        NSString *content = self.text;
        NSAttributedString *attributedText = self.attributedText;
        if(!content || content.length ==0 || !attributedText || attributedText.length == 0) {
            return;
        }
        sender.enabled = NO;
        CGPoint point = [sender locationInView:sender.view];
        CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
        CGMutablePathRef Path = CGPathCreateMutable();
        CGPathAddRect(Path, NULL, self.bounds);
        CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
        CFRange range = CTFrameGetVisibleStringRange(frame);
        if (attributedText.length > range.length) {
            UIFont *font = kFont14;
            CGPathRelease(Path);
            Path = CGPathCreateMutable();
            CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
            frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
        }
        CFArrayRef lines = CTFrameGetLines(frame);
        if (!lines) {
            CFRelease(frame);
            CFRelease(framesetter);
            CGPathRelease(Path);
            sender.enabled = YES;
            return;
        }
        CFIndex count = CFArrayGetCount(lines);
        CGPoint origins[count];
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
        CGAffineTransform transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
        CGFloat verticalOffset = 0;
        for (CFIndex i = 0; i < count; i++) {
            CGPoint linePoint = origins[i];
            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
            CGFloat flushFactor = [self getFlushFactor];
            CGFloat penOffset = CTLineGetPenOffsetForFlush(line, flushFactor, self.bounds.size.width);
            linePoint.x = penOffset;//考虑文本对齐方式对文字位置的影响
            CGFloat ascent = 0.0f;
            CGFloat descent = 0.0f;
            CGFloat leading = 0.0f;
            CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGFloat height = ascent + fabs(descent) + leading;
            CGRect flippedRect = CGRectMake(linePoint.x, linePoint.y , width, height);
            CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
            rect = CGRectInset(rect, 0, 0);
            rect = CGRectOffset(rect, 0, verticalOffset);
            NSParagraphStyle *style = [attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
            CGFloat lineSpace;
            if (style) {
                lineSpace = style.lineSpacing;
            }else {
                lineSpace = 0;
            }
            CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
            rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
            if (CGRectContainsPoint(rect, point)) {
                CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
                CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
                CGFloat offset;
                CTLineGetOffsetForStringIndex(line, index, &offset);
                if (offset > relativePoint.x) {
                    index = index - 1;
                }
                NSMutableDictionary *mapper = objc_getAssociatedObject(self, &UITextViewClickRangeMapperKey);
                __block BOOL containsInClickRange = NO;
                __block void(^handler)(UITextView *, UITapGestureRecognizer *);
                if(mapper) {
                    [mapper enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        NSString *rangeKey = key;
                        NSRange targetRange = NSRangeFromString(rangeKey);
                        if(targetRange.location + targetRange.length > content.length) {
                            targetRange = NSMakeRange(targetRange.location, content.length - targetRange.location);
                        }
                        if(NSLocationInRange(index, targetRange)) {
                            containsInClickRange = YES;
                            handler = mapper[rangeKey];
                        }
                    }];
                }
                if(containsInClickRange) {
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    sender.enabled = YES;
                    if(handler) {
                        handler(self, sender);
                    }
                    return;
                }
            }
        }
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        sender.enabled = YES;
}

- (CGFloat)getFlushFactor {
    NSTextAlignment alignment = self.textAlignment;
    if(alignment == NSTextAlignmentCenter) {
        return 0.5;
    } else if(alignment == NSTextAlignmentRight) {
        return 1.0;
    } else {
        return 0;
    }
}

/**
 * 处理UILabel的text的某个range的点击事件
 * clickRange UILabel的text的响应点击事件的范围
 * handler 点击给定范围内的字符串的回调
 */
- (void)handleClickAction:(UITapGestureRecognizer *)sender clickRange:(NSRange)clickRange clickHandler:(void(^)(UITextView *, UITapGestureRecognizer *))handler {
    NSString *content = self.text;
    NSAttributedString *attributedText = self.attributedText;
    if(!content || content.length ==0 || !attributedText || attributedText.length == 0 || clickRange.length == 0 || clickRange.location >= content.length) {
        return;
    }
    NSRange targetRange = clickRange;
    if(clickRange.location + clickRange.length > content.length) {
        targetRange = NSMakeRange(clickRange.location, content.length - clickRange.location);
    }
    sender.enabled = NO;
    CGPoint point = [sender locationInView:sender.view];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedText);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL, self.bounds);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    CFRange range = CTFrameGetVisibleStringRange(frame);
    if (attributedText.length > range.length) {
        UIFont *font = kFont14;
        CGPathRelease(Path);
        Path = CGPathCreateMutable();
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    CFArrayRef lines = CTFrameGetLines(frame);
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        sender.enabled = YES;
        return;
    }
    CFIndex count = CFArrayGetCount(lines);
    CGPoint origins[count];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    CGAffineTransform transform =  CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
    CGFloat verticalOffset = 0;
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat ascent = 0.0f;
        CGFloat descent = 0.0f;
        CGFloat leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat height = ascent + fabs(descent) + leading;
        CGRect flippedRect = CGRectMake(linePoint.x, linePoint.y , width, height);
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        rect = CGRectInset(rect, 0, 0);
        rect = CGRectOffset(rect, 0, verticalOffset);
        NSParagraphStyle *style = [attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        CGFloat lineSpace;
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        if (CGRectContainsPoint(rect, point)) {
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            CGFloat offset;
            CTLineGetOffsetForStringIndex(line, index, &offset);
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            if(NSLocationInRange(index, targetRange)) {
                CFRelease(frame);
                CFRelease(framesetter);
                CGPathRelease(Path);
                sender.enabled = YES;
                if(handler != nil) {
                    handler(self, sender);
                }
                return;
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    sender.enabled = YES;
}

@end
