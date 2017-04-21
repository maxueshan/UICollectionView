//
//  ViewController.m
//  Abe的瀑布流的封装
//
//  Created by dongge on 16/3/2.
//  Copyright © 2016年 Abe. All rights reserved.
//

#import "ViewController.h"

#import "WaterFlowModel.h"

#import "WaterFlowCell.h"

#import "WaterfallLayout.h"

#import "UIImageView+WebCache.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WaterfallLayoutDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;//创建可变数组,存储json文件数据

@end

@implementation ViewController


-(NSMutableArray *)dataArray{

    if (nil == _dataArray) {
        _dataArray = [NSMutableArray array];
    }

    return _dataArray;
    
}

//解析json文件

-(void)parserJsonData {

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"json"];

    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    
    NSMutableArray *arr = [NSMutableArray array ];
    
    arr = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingAllowFragments) error:nil];
    
    for (NSDictionary *dic in arr) {
        
        WaterFlowModel *model = [[WaterFlowModel alloc]init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        [self.dataArray addObject: model];
        
    }

}


//在viewDidLoad设置集合视图的flowLayout,我们要做的就是新创建一个继承于UICollectionViewLayout的类,在这个子类当中,做出瀑布流的布局.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WaterfallLayout *flowLayout = [[WaterfallLayout alloc] init];
    // 高度
    flowLayout.delegate = self;
    
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    
    flowLayout.itemSize = CGSizeMake(w, w);
    // 间隙
    flowLayout.insertItemSpacing = 10;
    // 内边距
    flowLayout.sectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    // 列数
    flowLayout.numberOfColumn = 2;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [self.view addSubview:collectionView];
    
    [collectionView registerClass:[WaterFlowCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    collectionView.backgroundColor = [UIColor whiteColor];
    [self parserJsonData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WaterFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WaterFlowModel *m = self.dataArray[indexPath.item];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:m.thumbURL]];
    return cell;
}


// 计算高度
- (CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath{
    WaterFlowModel *m = self.dataArray[indexPath.item];
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 40) / 3;
    CGFloat h = (w * m.height) / m.width;
    return h;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
