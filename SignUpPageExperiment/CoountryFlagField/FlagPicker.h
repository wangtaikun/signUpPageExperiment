//
//  FlagPicker.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/8.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlagPicker : UITextField<UIPickerViewDelegate, UIPickerViewDataSource>

@property(nonatomic,strong)UIImageView *flagShap;
@property (strong,nonatomic) NSMutableArray *allNations;
@property (assign,nonatomic) NSInteger chooseNationIndex;
@property (strong,nonatomic) UIPickerView *pickerView;

@end
