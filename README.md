# PaoFuScrollView

# 前言

类似泡芙的详情界面,一种线性特效的滚动轮播图,根据图片大小进行配置;

使用的时候,只需要把项目中的文件拖进您的项目,初始化传入一个图片模型的数组即可,具体可参照Demo,写的不好,望指教!!
    
![效果图](https://upload-images.jianshu.io/upload_images/1911628-489eb4e3653ef6ed.gif?imageMogr2/auto-orient/strip%7CimageView2/2/w/210)

# 主要代码

```
 //1.取出默认第一张的图片高度
    NSDictionary *dic = imageArr[0];
    CGFloat oneHeight = ScreenWidth * [ dic[@"height"] floatValue] / [ dic[@"width"] floatValue];
    UIScrollView *scroView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, oneHeight)];
    for (int i = 0 ; i < imagStringArr.count; i++) {
        //2.取出其他图片的高度并且赋值给imageView
        NSDictionary *otherDic = imageArr[i];
        CGFloat otherHeight = ScreenWidth * [ otherDic[@"height"] floatValue] / [ otherDic[@"width"] floatValue];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth *i, 0, ScreenWidth, otherHeight)];
        //3.这边给图片设置填充
        imageV.contentMode = UIViewContentModeScaleToFill;
        //4.加载图片
        [imageV sd_setImageWithURL:[NSURL URLWithString:imagStringArr[i]]];
        [scroView addSubview:imageV];
        //5.存放图片的高度 一一对应
        [_imageHeightArray addObject:@(otherHeight)];
        //6.存放ImageView对象
        [_itemArr addObject:imageV];
    }
    //7.设置一些常用属性
    scroView.delegate = self;
    scroView.bounces= false;
    scroView.pagingEnabled = YES;
    scroView.showsHorizontalScrollIndicator = NO;
    //8.滚动大小设置
    scroView.contentSize = CGSizeMake(ScreenWidth *imagStringArr.count, 0);
    self.scrollview = scroView;
    //9.添加到头部
    self.tableView.tableHeaderView = scroView;
    
```


```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
         //头部轮播图效果
         [self smallToBigAction];
}

```
```
-(void)smallToBigAction
{
    CGFloat scrollviewW =  self.scrollview.frame.size.width;
    CGFloat x = self.scrollview.contentOffset.x;
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
        CGRect frame = _scrollview.frame;
        frame.size.height = (nowH)+(actualOffset*offx);
        if (actualOffset!=0) {
            //过滤重新赋值scrollView的高
            _scrollview.frame = frame;
            UIImageView *currentImageView = _itemArr[nowPage];
            currentImageView.frame = CGRectMake(currentImageView.frame.origin.x, currentImageView.frame.origin.y, _scrollview.frame.size.width, _scrollview.frame.size.height);
        }
    }else
    {
        //从大到大
        //计算比例
        float offx = (nowH-nextH)/scrollviewW;
        //当前屏幕滚动的实际偏移量
        CGFloat actualOffset = x-(nowPage*scrollviewW);
        CGRect frame = _scrollview.frame;
        frame.size.height = (nowH)-(actualOffset*offx);
        if (actualOffset!=0) {
             //过滤重新赋值scrollView的高
            _scrollview.frame = frame;
            //设置当前imageView的frame
            UIImageView * currentImageView = _itemArr[nowPage];
            currentImageView.frame = CGRectMake(currentImageView.frame.origin.x, currentImageView.frame.origin.y, _scrollview.frame.size.width, _scrollview.frame.size.height);
           //设置下一张imageView的height 和frame
            CGRect nextFrame= next.frame;
            nextFrame.size.height = frame.size.height;
            next.frame = nextFrame;
        }
    }
    //最后刷新表~
    [self.tableView reloadData];
    
}
```


# Demo使用

```
  //demo图片格式.webp  传送门 ===> https://www.jianshu.com/p/c7cc89f69990
    NSArray *imageArrDic = @[
                          @{@"url":@"http://sf6-nhcdn-tos.pstatp.com/img/p1056/8ee334c3860c4f4ba76a5e08c13ee01f~1080x1920_q80.webp",@"width":@"1080",@"height":@"1920"},
                            @{@"url":@"http://sf1-nhcdn-tos.pstatp.com/img/p1056/c2be43ab532a4ccf897443913878ef86~1080x1920_q80.webp",@"width":@"1080",@"height":@"1920"},
                            @{@"url":@"http://sf3-nhcdn-tos.pstatp.com/img/p1056/bcc0272547e34fdea5f066f08729c3e6~640x426_q80.webp",@"width":@"640",@"height":@"426"},
                          @{@"url":@"http://sf1-nhcdn-tos.pstatp.com/img/p1056/5f55b98b7a214200995f9b2ee1160067~640x426_q80.webp",@"width":@"640",@"height":@"426"},
                          @{@"url":@"http://sf1-nhcdn-tos.pstatp.com/img/p1056/b0fc047ec3124503930310dc7dfaa0ed~1080x1920_q80.webp",@"width":@"1080",@"height":@"1920"},
                          ];
    
    NSMutableArray <SWScrollModel *>*imageArr = [NSMutableArray array];
    for (NSDictionary *dic in  imageArrDic) {
            SWScrollModel *model = [[SWScrollModel alloc]init];
            model.image_Url = dic[@"url"];
            model.image_Width = dic[@"width"];
            model.image_Height = dic[@"height"];
            [imageArr addObject:model];
    }
    
    
    _scrollview = [[SWCarouseView alloc]initImageArray:imageArr];
    _scrollview.delegates = self;
    self.tableView.tableHeaderView = _scrollview;
```

### 间书地址

 泡芙轮播图传送门(https://www.jianshu.com/p/2f3b2811e638)
