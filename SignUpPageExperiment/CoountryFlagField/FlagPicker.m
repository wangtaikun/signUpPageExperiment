//
//  FlagPicker.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "FlagPicker.h"

@implementation FlagPicker


-(void)setupNationFlagPicker {
// 创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = [UIColor grayColor];
    pickerView.tintColor = [UIColor redColor];
    self.layer.borderColor = [UIColor blackColor].CGColor;
    _pickerView = pickerView;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    self.inputView = pickerView;
}







- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}




@end
