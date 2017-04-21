//
//  ViewController.m
//  xsCollectionViewLayout
//
//  Created by xueshan on 17/3/16.
//  Copyright © 2017年 xueshan. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionViewLayout.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"

static NSString *cell1 = @"cell1";
static NSString *cell2 = @"cell2";
static NSString *cell3 = @"cell3";


@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initColectionV];

}

- (void)initColectionV{
    
    CustomCollectionViewLayout *layout = [[CustomCollectionViewLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview: self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"OneCell" bundle:nil] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"TwoCell" bundle:nil] forCellWithReuseIdentifier:@"cell2"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ThreeCell" bundle:nil] forCellWithReuseIdentifier:@"cell3"];

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 9;
            break;
        case 2:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell ;
    NSInteger sec = indexPath.section;
    if (sec == 0) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell1 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor redColor];
    }else if (sec == 1){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell2 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];

        
    }else if (sec == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell3 forIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        
    }
    
    return cell;
}

//头部视图
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//}

//item 大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section;
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;






@end






