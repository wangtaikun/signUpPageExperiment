//
//  ViewController.h
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#import "HeadPortraitImageView.h"
#import "BirthdayPicker.h"
#import "ProvinceCitysPickerView.h"

@interface ViewController: UIViewController <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UITextField *userNameTextField;
@property (strong, nonatomic) BirthdayPicker *birthdayPicker;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) ProvinceCitysPickerView *provincePicker;

@end

