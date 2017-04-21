//
//  WaterfallLayout.h
//  Abe的瀑布流的封装
//
//  Created by dongge on 16/3/2.
//  Copyright © 2016年 Abe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WaterfallLayoutDelegate <NSObject>

// 获取图片高度
- (CGFloat)heightForItemIndexPath:(NSIndexPath *)indexPath;

@end


@interface WaterfallLayout : UICollectionViewFlowLayout

// item大小
@property (nonatomic,assign)CGSize itemSize;

// 内边距
@property (nonatomic,assign)UIEdgeInsets sectionInsets;

// 间距
@property (nonatomic,assign)CGFloat insertItemSpacing;

// 列数
@property (nonatomic,assign)NSUInteger numberOfColumn;

// 代理（提供图片高度）
@property (nonatomic,weak)id<WaterfallLayoutDelegate>delegate;


@end
