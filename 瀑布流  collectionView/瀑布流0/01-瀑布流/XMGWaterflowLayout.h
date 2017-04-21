//
//  XMGWaterflowLayout.h
//  01-瀑布流
//
//  Created by xiaomage on 15/8/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMGWaterflowLayout;

//协议代理
@protocol XMGWaterflowLayoutDelegate <NSObject>
@required
- (CGFloat)waterflowLayout:(XMGWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth; //item 宽度

@optional
- (CGFloat)columnCountInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;   //多少列
- (CGFloat)columnMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout; //列间距
- (CGFloat)rowMarginInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;    //行间距
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(XMGWaterflowLayout *)waterflowLayout;//间距
@end








//
@interface XMGWaterflowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<XMGWaterflowLayoutDelegate> delegate;
@end













