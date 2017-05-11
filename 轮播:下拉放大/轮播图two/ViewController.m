//
//  ViewController.m
//  轮播图two
//
//  Created by FDC-iOS on 16/9/6.
//  Copyright © 2016年 meilun. All rights reserved.
//

#import "ViewController.h"
#import "YSCollectionView.h"
#import "HMObjcSugar.h"
#import "objc/runtime.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource,YSCollectionViewDelegate>

@end

NSString * const tableCellId = @"tableCellId";
#define kHeaderHeight 200
#define kPageHeight 20
#define kPageWidth 20

@implementation ViewController {
    NSArray <NSString *>           *_urls;
    YSCollectionView            *_collectionView;
    UIView                      *_header;
    UIStatusBarStyle            _statusBarYStyle;
    UIPageControl               *_myPageControl;
}

//创建图片地址字符串数组即可! 检查自己的是否支持HTTPS网络请求
- (void)loadDataFromNet {
    _urls = @[@"http://imgsrc.baidu.com/baike/pic/item/a6efce1b9d16fdfa241bf189b68f8c5494ee7b65.jpg",
              @"http://pic2016.5442.com:82/2016/0811/26/1.jpg%21960.jpg",
              @"http://imgsrc.baidu.com/forum/pic/item/5bb5c9ea15ce36d3da6bfdb93af33a87e850b1cf.jpg",
              @"http://image.tianjimedia.com/uploadImages/2012/178/K830IZAG0Q20.jpg"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setHidden:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self loadData];
    [self loadDataFromNet];
    [self addTableView];
    [self addHeardView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _statusBarYStyle = UIStatusBarStyleLightContent;
}

- (void)addTableView {
    UITableView * table = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:tableCellId];
    table.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
}

- (void)addHeardView {
    _header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.hm_width, kHeaderHeight)];
    _header.backgroundColor = [UIColor hm_colorWithHex:0xF8F8F8];
    [self.view addSubview:_header];
    
    _collectionView = [[YSCollectionView alloc] initWithUrls:_urls];
    _collectionView.pageDelegate = self;
    _collectionView.frame = CGRectMake(0, 0, self.view.hm_width, kHeaderHeight);
    [_header addSubview:_collectionView];
    
    [self addPageControl];
}
- (void)YSCollectionView:(UICollectionView *)collectionView WithCurrentPage:(NSInteger)currentPage {
    _myPageControl.currentPage = currentPage;
}
- (void)addPageControl {
    
    CGFloat pageW = kPageWidth * _urls.count;
    CGFloat pageH = kPageHeight;
    _myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_header.hm_width - pageW) * 0.5, _header.hm_height - pageH, pageW, pageH)];
//    _myPageControl.backgroundColor = [UIColor redColor];
    [_header addSubview:_myPageControl];
    _myPageControl.pageIndicatorTintColor = [UIColor greenColor];
    _myPageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _myPageControl.numberOfPages = _urls.count;
    
//    [self getUIPageControlProperties];
    [_myPageControl setValue:[UIImage imageNamed:@"pageCurrent.png"] forKey:@"_currentPageImage"];
    [_myPageControl setValue:[UIImage imageNamed:@"pageOther.png"] forKey:@"_pageImage"];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:tableCellId];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y + kHeaderHeight;
//    NSLog(@"%f",offset);
    if (offset < 0) {//向下
        NSDictionary *dic = @{
                              @"offset" : [NSString stringWithFormat:@"%f",offset]
                              };
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"zys" object:nil userInfo:dic];
        _header.hm_height = kHeaderHeight;
        _header.hm_y = 0;
        _header.hm_height = kHeaderHeight - offset;
        _collectionView.alpha = 1;
    } else {
        
        _header.hm_y = 0;
        CGFloat minOffset = kHeaderHeight - 64;
        _header.hm_y = minOffset > offset ? - offset : - minOffset;
        
        CGFloat progress = 1 - (offset / minOffset);
        _collectionView.alpha = progress;
        _statusBarYStyle = progress < 0.4 ? UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
        _myPageControl.alpha = progress;
    }
    _collectionView.hm_height = _header.hm_height;
    _myPageControl.hm_y = _header.hm_height - kPageHeight;
}




- (UIStatusBarStyle)preferredStatusBarStyle {
    return _statusBarYStyle;
}


// zhu yi  yi chu  tong  zhi ..  !移!除!
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"tingzhi" object:nil userInfo:nil];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"jixu" object:nil userInfo:nil];
}

@end
