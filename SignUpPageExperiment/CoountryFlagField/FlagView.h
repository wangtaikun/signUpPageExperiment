//
//  FlagView.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NationAndFlagModle.h"

@interface FlagView : UIView

@property (strong,nonatomic) UIImage *flagImage;
@property (strong,nonatomic) UILabel *nationName;
@property (strong,nonatomic) NationAndFlagModle *nation;

+(instancetype) FlagView;

@end
