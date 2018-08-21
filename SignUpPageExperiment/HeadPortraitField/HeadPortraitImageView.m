//
//  HeadPortraitImageView.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "HeadPortraitImageView.h"

@implementation HeadPortraitImageView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self drawRect:frame];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIImageView *imageview = [[UIImageView alloc] init];
    _irregularShapeIv = imageview;
    self.irregularShapeIv.userInteractionEnabled = YES;
    [_irregularShapeIv drawRect:rect];
    self.layer.cornerRadius = 20;
    self.layer.masksToBounds = YES;
    self.irregularShapeIv.image = [UIImage imageNamed:@"tropsticks"];
}

-(void)setirregularShapeIv:(UIImage*)image {
    _irregularShapeIv.image = image;
}

-(void)setIrregularShapeIv:(UIImageView *)irregularShapeIv {
    _irregularShapeIv = irregularShapeIv;
    [self setNeedsDisplay];
}

@end
