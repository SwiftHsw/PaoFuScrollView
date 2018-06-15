//
//  SWCarouseView.h
//  SWlinearScrollView
//
//  Created by Shiwen Huang on 2018/6/15.
//  Copyright © 2018年 Shiwen Huang. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SWScrollModel;

//代理
@protocol SWCarouseViewDelegate <NSObject>

//返回高度 ,刷新表格
- (void)updataScrollViewOffsetReload:(CGFloat)height;

//点击的第几个
- (void)didSelectImageItem:(NSInteger)index;


@end

@interface SWCarouseView : UIView
//初始化方法
-(instancetype)initImageArray:(NSMutableArray <SWScrollModel *>*)imageArray;

@property (assign,nonatomic)id <SWCarouseViewDelegate>delegates;

@property (retain,nonatomic)UIColor *currentPageTintColor;

@property (retain,nonatomic)UIColor *pageTintColor;
@end
