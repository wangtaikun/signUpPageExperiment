//
//  NationAndFlagModle.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NationAndFlagModle : NSObject
@property (strong,nonatomic) NSString *nation;
@property (strong,nonatomic) NSString *flag;

+(instancetype)NationAndFlagFill:(NSDictionary*)dic;

@end
