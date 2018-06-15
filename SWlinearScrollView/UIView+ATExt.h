//
//  UIView+ATExt.h
//  ATUtils
//
//  Created by  677676  on 2018/1/27.
//  Copyright © 2018年 艾腾软件.SW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ATExt)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign ,readonly) CGFloat maxX;
@property (nonatomic, assign ,readonly) CGFloat maxY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property(nonatomic,assign)CGFloat getY;
@property(nonatomic,assign)CGFloat getX;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;

//获取当前view所在的控制器
- (UIViewController*)getCurrentViewController;
//获取当前类的XIB 类直接调用
+(instancetype)at_viewFromXib;
//view直接添加手势
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action;
- (UITapGestureRecognizer *)addTapGestureRecognizer:(SEL)action target:(id)target;
//添加长按手势
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action duration:(CGFloat)duration;
//添加长按手势 几秒后相应
- (UILongPressGestureRecognizer *)addLongPressGestureRecognizer:(SEL)action target:(id)target duration:(CGFloat)duration;
//移除当前View所有子视图
- (void)removeAllSubviews;
@end
