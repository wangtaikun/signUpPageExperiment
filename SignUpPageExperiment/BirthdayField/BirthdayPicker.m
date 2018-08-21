//
//  BirthdayPicker.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "BirthdayPicker.h"

@interface BirthdayPicker()

@property(nonatomic, strong) NSDateFormatter *dfm;

@end
@implementation BirthdayPicker

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

// 初始化
- (void)setUp {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    _birthdayChoosePicker = datePicker;
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.borderStyle = UITextBorderStyleLine;
    // 设置地区 zh:中国标识
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    if (!_dfm) {
        _dfm = [[NSDateFormatter alloc] init];
        _dfm.dateFormat = @"yyyy-MM-dd";
    }
    NSDate *minDate = [self.dfm dateFromString:@"1953-1-1"];
    NSDate *maxDate = [self.dfm dateFromString:@"2000-12-31"];
    datePicker.minimumDate = minDate;
    datePicker.maximumDate = maxDate;
    datePicker.date = maxDate;
    // 自定义文本框的键盘
    self.inputView = datePicker;
}

// 只要UIDatePicker选中的时候调用
- (void)dateChange:(UIDatePicker *)picker {
    self.text = [self.dfm stringFromDate:picker.date];
}

@end
