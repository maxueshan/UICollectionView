//
//  CustomFlowLayout.m
//  瀑布流
//
//  Created by qianfeng on 16/6/7.
//  Copyright © 2016年 DSY. All rights reserved.
//

#import "CustomFlowLayout.h"

@interface CustomFlowLayout()

@property (nonatomic, strong) NSMutableArray * layoutAttributesArray;

@end

@implementation CustomFlowLayout


- (void)prepareLayout {
    
    CGFloat contentWidth = self.collectionView.bounds.size.width - self.sectionInset.left - self.sectionInset.right;
    
    CGFloat marginX = self.minimumInteritemSpacing;
    
    CGFloat itemWidth = (contentWidth - marginX * (self.columnCount - 1)) / self.columnCount;
    
    // 计算布局属性
    [self computeAttributesWithItemWidth:itemWidth inSection:0];
}

- (void)computeAttributesWithItemWidth:(CGFloat)itemWidth inSection:(NSInteger)section {
    
    // 定义一个列高数组,记录每一列的高度
    CGFloat columnHeight[self.columnCount];
    // 定义一个记录每一列中item个数的数组
    CGFloat columnItemCount[self.columnCount];
    
    // 初始化
    for (int i = 0; i < self.columnCount; i++) {
        
        columnHeight[i] = self.sectionInset.top;
        columnItemCount[i] = 0;
    }
    
    // 遍历 数组, 计算相关属性
    NSInteger index = 0;
    
    // 只有一个section
    NSInteger totalCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:section];
    
    NSMutableArray * attributesArr = [NSMutableArray arrayWithCapacity:totalCount];
    
    for (NSInteger i = 0; i < totalCount; i++) {
        // 建立布局属性
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:section];
        
        UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 找出最短列号
        NSInteger columnIdxOfShortest = [self shortestColumn:columnHeight];
        
        // 数据追加在最短列
        columnItemCount[columnIdxOfShortest]++;
        
        // X值 (x起点)
        CGFloat itemX = (itemWidth + self.minimumInteritemSpacing) * columnIdxOfShortest + self.sectionInset.left;
        
        // Y值 (y起点)
        CGFloat itemY = columnHeight[columnIdxOfShortest];
        
        
        CGSize itemOriginalSize = [self.delegate sizeForItemWithIndexPath:indexPath];
        
        // 等比例缩放, 计算item的高度
        CGFloat itemH = itemOriginalSize.height * itemWidth / itemOriginalSize.width;
        
        // 设置frame
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemH);
        
        [attributesArr addObject:attributes];
        
        // 高度累加
        columnHeight[columnIdxOfShortest] += itemH + self.minimumLineSpacing;
        
        
    }
    
    // 找出最高列的下标
    NSInteger columnIndexOfHighest = [self highestColumn:columnHeight];

    // 根据最高类设置itemSize 使用总高度的平均值
    // 行数
    NSInteger averageCount = totalCount % self.columnCount? totalCount / self.columnCount + 1: totalCount / self.columnCount;
    
    CGFloat itemH = (columnHeight[columnIndexOfHighest] / averageCount) - self.minimumLineSpacing;
    
    // 是为了计算contentsize的大小
    self.itemSize = CGSizeMake(itemWidth, itemH);
    
//    self.collectionView.contentSize = CGSizeMake(self.collectionView.bounds.size.width, columnHeight[columnIndexOfHighest]);
    
    self.layoutAttributesArray = attributesArr.copy;
}

- (NSInteger)shortestColumn:(CGFloat *)columeHeight {
    
    CGFloat shortestH = CGFLOAT_MAX;
    NSInteger index = 0;
    
    for (NSInteger i = 0; i < self.columnCount; i++) {
        
        if (columeHeight[i] < shortestH) {
            shortestH = columeHeight[i];
            index = i;
        }
    }
    
    return index;
}

- (NSInteger)highestColumn:(CGFloat *)columeHeight {
    
    CGFloat shortestH = CGFLOAT_MIN;
    
    NSInteger index = 0;
    
    for (NSInteger i = 0; i < self.columnCount; i++) {
        
        if (columeHeight[i] > shortestH) {
            shortestH = columeHeight[i];
            index = i;
        }
    }
    
    return index;
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return self.layoutAttributesArray[indexPath.item];
//}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    return self.layoutAttributesArray;
}

     
@end
