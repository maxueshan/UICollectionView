//
//  WaterfallLayout.m
//  Abe的瀑布流的封装
//
//  Created by dongge on 16/3/2.
//  Copyright © 2016年 Abe. All rights reserved.
//

#import "WaterfallLayout.h"


@interface WaterfallLayout()


// 所有Item的数量
@property (nonatomic,assign)NSUInteger numberOfItems;

// 这是一个数组，保存每一列的高度
@property (nonatomic,strong)NSMutableArray *columnHeights;
// 这是一个数组，数组中保存的是一种类型，这种类型决定item的位置和大小。
@property (nonatomic,strong)NSMutableArray *itemAttributes;
// 获取最长列索引
- (NSInteger)indexForLongestColumn;
// 获取最短列索引
- (NSInteger)indexForShortestColumn;


@end

@implementation WaterfallLayout


- (NSMutableArray *)columnHeights{
    if (nil == _columnHeights) {
        self.columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

-(NSMutableArray *)itemAttributes{
    if (nil == _itemAttributes) {
        self.itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}


// 获取最长列索引
- (NSInteger)indexForLongestColumn{
    // 记录索引
    NSInteger longestIndex = 0;
    // 记录当前最长列高度
    CGFloat longestHeight = 0;
    for (int i = 0; i < self.numberOfColumn; i++) {
        // 取出列高度
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        // 判断
        if (currentHeight > longestHeight) {
            longestHeight = currentHeight;
            longestIndex = i;
        }
    }
    return longestIndex;
    
}
// 获取最短列索引
- (NSInteger)indexForShortestColumn{
    
    // 记录索引
    NSInteger shortestIndex = 0;
    
    // 记录最短高度
    CGFloat shortestHeight = MAXFLOAT;
    for (int i = 0; i < self.numberOfColumn; i++) {
        
        CGFloat currentHeight = [self.columnHeights[i] floatValue];
        if (currentHeight < shortestHeight) {
            shortestHeight = currentHeight;
            shortestIndex = i;
        }
    }
    return shortestIndex;
}

// 这里计算每一个item的x，y，w，h。并放入数组
-(void)prepareLayout{
    [super prepareLayout];
    
    // 循环添加top高度
    for (int i = 0; i < self.numberOfColumn; i++) {
        self.columnHeights[i] = @(self.sectionInsets.top);
    }
    
    // 获取item数量
    self.numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    // 循环计算每一个item的x,y,width,height
    for (int i = 0; i < self.numberOfItems; i++) {
        
        // x,y
        
        // 获取最短列
        NSInteger shortIndex = [self indexForShortestColumn];
        
        // 获取最短列高度
        CGFloat shortestH = [self.columnHeights[shortIndex] floatValue];
        
        // x
        CGFloat detalX = self.sectionInsets.left + (self.itemSize.width + self.insertItemSpacing) * shortIndex;
        
        // y
        CGFloat detalY = shortestH + self.insertItemSpacing;
        
        // h
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        CGFloat itemHeight = 0;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(heightForItemIndexPath:)]){
            itemHeight = [self.delegate heightForItemIndexPath:indexPath];
        }
        
        // 保存item frame属性的对象
        UICollectionViewLayoutAttributes *la = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        la.frame = CGRectMake(detalX, detalY, self.itemSize.width, itemHeight);
        
        // 放入数组
        [self.itemAttributes addObject:la];
        
        // 更新高度
        self.columnHeights[shortIndex] = @(detalY + itemHeight);
    }
}


// 计算contentSize
- (CGSize)collectionViewContentSize{
    // 获取最高列
    NSInteger longestIndex = [self indexForLongestColumn];
    CGFloat longestH = [self.columnHeights[longestIndex] floatValue];
    
    // 计算contentSize
    CGSize contentSize = self.collectionView.frame.size;
    contentSize.height = longestH + self.sectionInsets.bottom;
    
    return contentSize;
}

// 返回所有item的位置和大小(数组)
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.itemAttributes;
}



@end
