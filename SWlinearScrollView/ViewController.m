//
//  ViewController.m
//  SWlinearScrollView
//
//  Created by Shiwen Huang on 2018/6/15.
//  Copyright © 2018年 Shiwen Huang. All rights reserved.
//

#import "ViewController.h"
#import "SWCarouseView.h"
#import "SWScrollModel.h"

@interface ViewController ()<SWCarouseViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)SWCarouseView *scrollview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
//      
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//返回高度 ,刷新表格
- (void)updataScrollViewOffsetReload:(CGFloat)height{
    [_tableView reloadData];
}

//点击的第几个
- (void)didSelectImageItem:(NSInteger)index{
    
}

@end
