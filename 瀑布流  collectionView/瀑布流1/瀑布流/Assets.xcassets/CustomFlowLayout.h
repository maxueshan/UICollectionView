//
//  CustomFlowLayout.h
//  瀑布流
//
//  Created by qianfeng on 16/6/7.
//  Copyright © 2016年 DSY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomFlowLayoutDelegate <NSObject>

- (CGSize)sizeForItemWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface CustomFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <CustomFlowLayoutDelegate> delegate;

// 总列数
@property (nonatomic, assign) NSInteger columnCount;

@end
