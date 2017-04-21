//
//  ViewController.m
//  瀑布流
//
//  Created by qianfeng on 16/6/7.
//  Copyright © 2016年 DSY. All rights reserved.
//

#import "ViewController.h"
#import "CustomFlowLayout.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, CustomFlowLayoutDelegate>
{
    CustomFlowLayout * _customLayout;
    UICollectionView * _collectionView;
}

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _customLayout = [[CustomFlowLayout alloc] init];
    
    _customLayout.minimumInteritemSpacing = 10;
    
    _customLayout.minimumLineSpacing = 10;
    
    _customLayout.columnCount = 3;
    
    _customLayout.delegate = self;
    
    _customLayout.sectionInset = UIEdgeInsetsMake(20, 10, 10, 10);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_customLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.dataSource = self;
    
    _collectionView.delegate = self;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UILabel * label = [cell.contentView viewWithTag:111];
    if (!label) {
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
        
        label.tag = 111;
        
        [cell.contentView addSubview:label];
    }
    label.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        
        _dataSource = [NSMutableArray arrayWithCapacity:100];
        
        for (NSInteger i = 0; i < 100; i++) {
            
            NSValue * value = [NSValue valueWithCGSize:CGSizeMake(100, (arc4random() % 100) + 100)];
            
            [_dataSource addObject:value];
        }
    }
    
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)sizeForItemWithIndexPath:(NSIndexPath *)indexPath {
    
    return [self.dataSource[indexPath.item] CGSizeValue];
}

@end
