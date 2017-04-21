//
//  CustomCollectionViewLayout.m
//  xsCollectionViewLayout
//
//  Created by xueshan on 17/3/16.
//  Copyright © 2017年 xueshan. All rights reserved.
//

#import "CustomCollectionViewLayout.h"


#define BXScreenH [UIScreen mainScreen].bounds.size.height
#define BXScreenW [UIScreen mainScreen].bounds.size.width
#define BXScreenBounds [UIScreen mainScreen].bounds
//首页坐标定义
#define IMG_TOP_HEIGHT  360/2
#define HomeBannerViewHegiht  265/2

@interface CustomCollectionViewLayout ()
{
    
    CGFloat _bannerMaxY;//第一个区的最大高度
    CGFloat _TowMaxY;//第二个区的最大高度
    CGFloat _rankingMaxY;//第三个区的最大高度
    CGFloat _height[2];//定义一个有两个元素的数组,里面存的是瀑布流左右两行的高度.
    NSMutableArray* _allLayoutAttributes;
    
}
@end
@implementation CustomCollectionViewLayout
//collectionView显示前会调用这个方法
-(void)prepareLayout
{
    //UICollectionViewLayoutAttributes对象,存入数组.
    
    _allLayoutAttributes =[[NSMutableArray alloc] initWithCapacity:0];
    //获得collectionView有多少个区
    NSInteger sections = [self.collectionView numberOfSections];
    for (int i = 0; i < sections; i ++) {
        
        //获得某一个区有多少个item
        NSInteger items = [self.collectionView numberOfItemsInSection:i];
        
        for (int j = 0; j < items; j ++) {
            //获得每一个item的indexPath
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            //通过indexPath创建layoutAttributes对象
            //一般,我们拿到对象以后,就设置他的属性,比如frame
            UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            [_allLayoutAttributes addObject:attributes];
            
            //先计算 第二去 Cell 的高度
            __block CGFloat  width;
            __block CGFloat  heigth;
            
            switch (i) {
                case 0:
                    
                    attributes.frame = CGRectMake(0.0f, 0.0f, BXScreenW, IMG_TOP_HEIGHT);
                    
                    break;
                case 1://section == 1时,每个item的尺寸
                    
                    width  = (BXScreenW -1*2)/3;
                    heigth = (BXScreenH - 64 - IMG_TOP_HEIGHT - HomeBannerViewHegiht -4)/3;
                    
                    attributes.frame = CGRectMake(0.0f + (width + 1.0f) * (j % 3), _bannerMaxY + 2 +(heigth +1) * (j / 3) , width, heigth);
                    break;
                    
                case 2:
                    
                    attributes.frame = CGRectMake(0.0f, _TowMaxY + 8 + (HomeBannerViewHegiht *j)+(15*j), BXScreenW, HomeBannerViewHegiht);
                    
                    break;
                default:
                    break;
            }
            
            if (j == items - 1) {
                
                CGFloat maxY = CGRectGetMaxY(attributes.frame);
                //如果是最后一个item
                switch (i) {
                    case 0:
                        _bannerMaxY  = maxY;//sec==0 的最大Y
                        break;
                    case 1:
                        _TowMaxY     = maxY;//sec==1 的最大Y
                        _height[0]   = _TowMaxY;
                        break;
                    case 2:
                        _rankingMaxY = maxY;//sec==2 的最大Y
                        _height[1]   = maxY;
                        break;
                        
                    default:
                        break;
                }
                
            }
            
        }
        
    }
    
    
}

//返回UICollectionView可滑动区域
- (CGSize)collectionViewContentSize {
    
    return CGSizeMake(CGRectGetWidth(self.collectionView.bounds), _height[0] > _height[1] ? _height[0] : _height[1]);
}

//返回Rect区域内需要显示的item的layoutAttributes
- (NSArray* )layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSLog(@"%@", NSStringFromCGRect(rect));
    NSMutableArray* layoutAttributes = [[NSMutableArray alloc] initWithCapacity:0];
    
    //遍历全的item位置,判断item的frame和rect是否相交,有重合的地方,如果有,就放入数组,返回
    for (UICollectionViewLayoutAttributes* attributes in _allLayoutAttributes) {
        //判断两个矩形是否相交
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
        
        //判断rect是否包含Attributes.frame
        if (CGRectContainsRect(rect, attributes.frame)) {
            [layoutAttributes addObject:attributes];
        }
    }
    
    return layoutAttributes;
}
@end




