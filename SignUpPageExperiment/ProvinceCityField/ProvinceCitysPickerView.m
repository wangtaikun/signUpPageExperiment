//
//  ProvinceCitysPickerView.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "ProvinceCitysPickerView.h"
#import "ProvinceModule.h"
@implementation ProvinceCitysPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpProvincePicker];
    }
    return self;
}

- (void)setUpProvincePicker {
    // 创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = [UIColor grayColor];
    pickerView.tintColor = [UIColor redColor];
    self.borderStyle = UITextBorderStyleLine;
    _pickerView = pickerView;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // 自定义文本框键盘
    self.inputView = pickerView;
}

- (NSMutableArray *)allProvinces {
    if (_allProvinces == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citys.plist" ofType:nil];
        NSArray *rootArry = [NSArray arrayWithContentsOfFile:filePath];
        _allProvinces = [[NSMutableArray alloc]init];
        //所有省模型放入allprovince可变数组
        for(NSDictionary *dit in rootArry) {
            ProvinceModule *temp = [ProvinceModule provinceFill:dit];
            [_allProvinces addObject:temp];
        }
    }
    return _allProvinces;
}

#pragma mark - 数据源方法

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // 第0列描述省,第0列行数,是文件中省的数量
    if (component == 0) {
        return self.allProvinces.count;
        //        return 100;
    } else {
        // 第1列描述第0列选中的省中的市,第1列的行数决定于省内城市数
        // 获取第0列选中的省模型返回第1列行数
        ProvinceModule *temp =  [self.allProvinces objectAtIndex:_chooseIndex];
        return temp.city.count;
    }
}

//显示每一行文字
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        // 描述省会的标题,获取对应的省模型
        ProvinceModule *temp = self.allProvinces[row];
        return temp.provinceName;
    } else {
        // 描述选中的省的城市标题
        // 获取第0列选中的省会模型
        ProvinceModule *temp =  self.allProvinces[_chooseIndex];
        // 获取城市标题
        return temp.city[row];
    }
}

//选中某一行时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component {
    if (component == 0) {
        // 滚动省，记录选中的省的角标
        _chooseIndex = row;
        // 刷新第1列的城市
        [pickerView reloadComponent:1];
        // 让pickerView选中第1列第0行
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    // 获取选中的省
    ProvinceModule *temp = self.allProvinces[_chooseIndex];
    // 获取选中的城市
    NSArray *cities = temp.city;
    // 获取第1列选中的行
    NSInteger cityIndex = [pickerView selectedRowInComponent:1];
    // 获取选中的城市
    NSString *cityName = cities[cityIndex];
    // 给文本框赋值
    self.text = [NSString stringWithFormat:@"%@ %@",temp.provinceName, cityName];
}

@end
