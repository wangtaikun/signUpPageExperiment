//
//  ProvinceModule.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModule : NSObject

@property (strong,nonatomic) NSMutableArray *city;
@property (strong,nonatomic) NSString *provinceName;
+(instancetype)provinceFill:(NSDictionary *) dic;

@end
