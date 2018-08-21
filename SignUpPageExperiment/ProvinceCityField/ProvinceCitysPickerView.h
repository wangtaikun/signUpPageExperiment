//
//  ProvinceCitysPickerView.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProvinceCitysPickerView : UITextField <UIPickerViewDelegate,UIPickerViewDataSource>

@property (strong, nonatomic) NSMutableArray *allProvinces;
@property (assign, nonatomic) NSInteger chooseIndex;        
@property (strong, nonatomic) UIPickerView *pickerView;

@end
