//
//  NationAndFlagModle.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "NationAndFlagModle.h"

@implementation NationAndFlagModle

+(instancetype)NationAndFlagFill:(NSDictionary*)dic {
    NationAndFlagModle *temp = [[NationAndFlagModle alloc]init];
    [temp setValuesForKeysWithDictionary:dic];
    return temp;
}

@end
