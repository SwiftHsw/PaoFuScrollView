//
//  UIView+ATExt.m
//  ATUtils
//
//  Created by  677676  on 2018/1/27.
//  Copyright © 2018年 艾腾软件.SW. All rights reserved.
//

#import "UIView+ATExt.h"

@implementation UIView (ATExt)

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setMaxX:(CGFloat)maxX{
    
}
-(CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

-(void)setMaxY:(CGFloat)maxY{
    
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}



- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}
 
 
- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(CGFloat)getX{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

-(CGFloat)getY{
    return CGRectGetMaxY(self.frame);
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}



- (UIViewController*)getCurrentViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+(instancetype)at_viewFromXib
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
#pragma mark -

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    return tap;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}

- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration {
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:action];
    longPress.minimumPressDuration = duration;
    [self addGestureRecognizer:longPress];
    
    return longPress;
}
-(void)removeAllSubviews{
//    for (UIView * view in self.subviews) {
//        [view removeFromSuperview];
//    }
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
