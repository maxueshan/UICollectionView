//
//  WaterFlowCell.m
//  Abe的瀑布流的封装
//
//  Created by dongge on 16/3/2.
//  Copyright © 2016年 Abe. All rights reserved.
//

#import "WaterFlowCell.h"

@implementation WaterFlowCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.imgView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        
        [self.contentView addSubview:_imgView];
        
    }
    
    return self;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.imgView.frame = self.contentView.bounds;
    
}



@end
