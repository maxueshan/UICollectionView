//
//  WaterFlowModel.h
//  Abe的瀑布流的封装
//
//  Created by dongge on 16/3/2.
//  Copyright © 2016年 Abe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface WaterFlowModel : NSObject

@property(nonatomic,strong)NSString *thumbURL;//图片地址

@property(nonatomic,assign)CGFloat  width;//图片的宽度

@property(nonatomic,assign)CGFloat  height;//图片的高度

@end
