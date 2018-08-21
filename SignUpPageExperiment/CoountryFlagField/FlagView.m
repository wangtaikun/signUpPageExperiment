//
//  FlagView.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "FlagView.h"

@implementation FlagView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if(self) {
        [self drawRect:frame];
//        [self setupNationFlagPicker];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    [self.flagImage drawInRect:rect];
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
}
-(void)seflagShap:(UIImage *)flagShap {
    _flagImage = flagShap;
    [self setNeedsDisplay];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
