//
//  ProvinceModule.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "ProvinceModule.h"

@implementation ProvinceModule

+(instancetype)initWithProvinceAndCity:(NSDictionary *)dic {
    ProvinceModule *temp = [[self alloc]init];
    [temp setValuesForKeysWithDictionary:dic];
    return temp;
}

@end
