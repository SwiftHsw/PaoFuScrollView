//
//  SWCarouseView.m
//  SWPay_HX
//
//  CreSWed by Shiwen Huang on 2018/6/14.
//  Copyright © 2018年 艾腾软件.SW. All rights reserved.
//

#import "SWCarouseView.h"
#import "SWScrollModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+ATExt.h"

#define kImageHeight(h,w)  [[UIScreen mainScreen] bounds].size.width * [h floatValue]/[w floatValue]

@interface SWCarouseView() <UIScrollViewDelegate>
//存放高度
@property (strong,nonatomic) NSMutableArray *imageHeightArray;
//存放图片对象
@property (strong,nonatomic) NSMutableArray *itemArr;
//存放图片,宽度,高度 的模型数组
@property (strong,nonatomic) NSMutableArray *imageArray;
//分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
//pageControl图片大小
@property (nonatomic, assign) CGSize pageImageSize;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation SWCarouseView

#pragma mark -
#pragma mark - 初始化

-(instancetype)initImageArray:(NSMutableArray <SWScrollModel *>*)imageArray{
    if (self = [super init]) {
        _imageArray = imageArray;
        _imageHeightArray = [NSMutableArray array];
        _itemArr = [NSMutableArray array];
        
        SWScrollModel * fistModel = imageArray[0];
        //默认设置第一张图片高度
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,kImageHeight(fistModel.image_Height, fistModel.image_Width));
        [self addSubview:self.scrollView];
        
        //创建多张图片
        for (int i = 0 ; i < imageArray.count; i++) {
            SWScrollModel * model = imageArray[i];
            CGFloat otherHeight =  kImageHeight(model.image_Height, model.image_Width);
            UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width *i,0,[[UIScreen mainScreen] bounds].size.width,otherHeight)];
            imageV.contentMode = UIViewContentModeScaleToFill;
            [imageV sd_setImageWithURL:[NSURL URLWithString:model.image_Url]];
            [self.scrollView addSubview:imageV];
            [_imageHeightArray addObject:@(otherHeight)];
            [_itemArr addObject:imageV];
        }
        
        //添加Page
        [self addSubview:self.pageControl];
        
    }
    return self;
}


#pragma mark -
#pragma mark -UIScrollViewdelegSWe
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.scrollView) {
        [self samllToBigScroll];
    }
    
}
//视图减速停止
- (void)scrollViewDidEndDecelerSWing:(UIScrollView *)scrollView{
    //滚动换页码
    self.pageControl.currentPage = scrollView.contentOffset.x / [[UIScreen mainScreen] bounds].size.width;
    
}


#pragma mark -
#pragma mark - 特效代码
- (void)samllToBigScroll{
    CGFloat scrollviewW =  self.scrollView.frame.size.width;
    CGFloat x = self.scrollView.contentOffset.x;
    int page = x /  scrollviewW;
    int nowPage = page;
    //下一页
    int nextPage = page+1;
    //下一页所需要展示的高度
    if (nextPage>=_imageHeightArray.count) {
        return;
    }
    UIImageView *next = _itemArr[nextPage];
    //每次滚动获取当前和下一页的高度
    float nowH = [_imageHeightArray[nowPage] floatValue];
    float nextH = [_imageHeightArray[nextPage] floatValue];
    if (nowH < nextH) {//从小到大
        //计算比例
        float offx = (nextH-nowH)/scrollviewW;
        //当前屏幕滚动的实际偏移量
        CGFloat actualOffset = x-(nowPage*scrollviewW);
        CGRect frame = self.scrollView.frame;
        frame.size.height = (nowH)+(actualOffset*offx);
        if (actualOffset!=0) {
            //过滤重新赋值scrollView的高
            self.scrollView.frame = self.frame =  frame;
            UIImageView *currentImageView = _itemArr[nowPage];
            currentImageView.frame = CGRectMake(currentImageView.frame.origin.x, currentImageView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            //同步pageControlY
            self.pageControl.y = self.height - 30;
        }
    }else{
        //从大到大
        //计算比例
        float offx = (nowH-nextH)/scrollviewW;
        //当前屏幕滚动的实际偏移量
        CGFloat actualOffset = x-(nowPage*scrollviewW);
        CGRect frame = self.scrollView.frame;
        frame.size.height = (nowH)-(actualOffset*offx);
        if (actualOffset!=0) {
            //过滤重新赋值scrollView的高
            self.scrollView.frame = self.frame =  frame;
            //设置当前imageView的frame
            UIImageView * currentImageView = _itemArr[nowPage];
            currentImageView.frame = CGRectMake(currentImageView.frame.origin.x, currentImageView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
            //设置下一张imageView的height 和frame
            CGRect nextFrame= next.frame;
            nextFrame.size.height = frame.size.height;
            next.frame = nextFrame;
            //同步pageControlY
            self.pageControl.y = self.height - 30;
        }
    }
    
    // 回调
    if ([self.delegates respondsToSelector:@selector(updataScrollViewOffsetReload:)]) {
        [self.delegates updataScrollViewOffsetReload:self.scrollView.frame.size.height];
    }
}

#pragma mark -
#pragma mark - Lazy
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.height - 30, self.width *.5, 30)];
        _pageControl.centerX = self.centerX;
        [_pageControl setCurrentPage:0];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        //设置_pageControl被点击事件
        [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
        _pageControl.numberOfPages = _imageArray.count;
    }
    return _pageControl;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.frame = self.frame;
        _scrollView.delegate = self;
        _scrollView.bounces= false;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width *_imageArray.count, 0);
        //单击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClick:)];
        //点击次数,默认是1,如果大于1表次需要连续点多少次才会调用事件
        tap.numberOfTapsRequired = 1;
        //需要几根手指点击,默认为1
        tap.numberOfTouchesRequired = 1;
        //附着在视图上
        [_scrollView addGestureRecognizer:tap];
    }
    return _scrollView;
}

#pragma mark -
#pragma mark - 外部传入
- (void)setCurrentPageTintColor:(UIColor *)currentPageTintColor{
    _currentPageTintColor =currentPageTintColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageTintColor;
}

- (void)setPageTintColor:(UIColor *)pageTintColor{
    _pageTintColor = pageTintColor;
    self.pageTintColor = pageTintColor;
}

#pragma mark - Action
//page点击方法
- (void)changePage{
    [self.scrollView setContentOffset:CGPointMake([[UIScreen mainScreen] bounds].size.width * self.pageControl.currentPage, 0) animated:YES];
    [self samllToBigScroll];
}
//图片点击事件
- (void)onClick:(id)sender
{
    if (self.delegates != nil) {
        if ([self.delegates respondsToSelector:@selector(didSelectImageItem:)]) {
            [self.delegates didSelectImageItem:self.pageControl.currentPage];
        }
    }
}



@end
