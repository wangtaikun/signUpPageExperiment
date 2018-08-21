//
//  ViewController.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/7.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "ShowViewController.h"

@interface ViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) UILabel *userNamelab;
@property (strong, nonatomic) UILabel *birthdaylab;
@property (strong, nonatomic) UILabel *provincelab;
@property (strong, nonatomic) UILabel *locationLab;
@property (strong, nonatomic) UIButton *signInbtn;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (strong, nonatomic) MBProgressHUD *HUD;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self freshUI];
    [self autolayoutFirstView];
    [self startLocation];
}

-(void)freshUI {
    [self setupHeadImage];
    [self setupName];
    [self setupBirthday];
    [self setupProvince];
    [self setupJumpButton];
    [self setupLocationLab];
    self.navigationItem.title = @"注册";
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:nil action:nil];
}

-(void)setupName {
    if (!_userNamelab) {
        _userNamelab = [[UILabel alloc] init];
        _userNamelab.text = @"昵称：";
        _userNamelab.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:_userNamelab];
    }
    if (!_userNameTextField) {
        _userNameTextField = [[UITextField alloc] init];
        _userNameTextField.backgroundColor = [UIColor whiteColor];
        _userNameTextField.borderStyle = UITextBorderStyleLine;
        _userNameTextField.placeholder = @"请填写昵称";
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
        _userNameTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userNameTextField.userInteractionEnabled =YES;
        _userNameTextField.delegate = self;
        _userNameTextField.keyboardType = UIKeyboardTypeDefault;
        _userNameTextField.keyboardAppearance = UIKeyboardAppearanceDefault;
        _userNameTextField.clearsOnBeginEditing = YES;
        [self.view addSubview:_userNameTextField];
    }
}

-(void)setupBirthday {
    if (!_birthdaylab) {
        _birthdaylab = [[UILabel alloc] init];
        _birthdaylab.text = @"生日：";
        _birthdaylab.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:_birthdaylab];
    }
    if(!_birthdayPicker) {
        _birthdayPicker = [[BirthdayPicker alloc] init];
        //设置左边间距
        _birthdayPicker.leftViewMode = UITextFieldViewModeAlways;
        _birthdayPicker.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        _birthdayPicker.placeholder = @" 请选择您的生日";
        [self.view addSubview:_birthdayPicker];
    }
}

-(void)setupProvince {
    if (!_provincelab) {
        _provincelab = [[UILabel alloc] init];
        _provincelab.text = @"户籍：";
        _provincelab.font = [UIFont systemFontOfSize:11];
        [self.view addSubview:_provincelab];
    }
    if (!_provincePicker) {
        _provincePicker = [[ProvinceCitysPickerView alloc] init];
        _provincePicker.leftViewMode = UITextFieldViewModeAlways;
        _provincePicker.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 0)];
        self.provincePicker.placeholder = @"请选择户籍所在地";
        [self.view addSubview:_provincePicker];
    }
}

-(void)setupJumpButton {
    if (!_signInbtn) {
        _signInbtn = [[UIButton alloc]init];
        [_signInbtn setTitle:@"确认" forState:UIControlStateNormal];
        [_signInbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_signInbtn setBackgroundColor:[UIColor lightGrayColor]];
        [self.view addSubview:_signInbtn];
    }
    [_signInbtn addTarget:self action:@selector(startJump:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupHeadImage {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"tropsticks"];
        _headImageView.layer.cornerRadius = 20;
        //视图的图层上的子图层,如果超出父图层的部分就截取掉
        _headImageView.layer.masksToBounds = YES;
        _headImageView.userInteractionEnabled = YES;
        [self.view addSubview:_headImageView];
    }
    [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
}

-(void)setupLocationLab {
    if (!_locationLab) {
        _locationLab = [[UILabel alloc] init];
        _locationLab.font = [UIFont systemFontOfSize:20];
        _locationLab.textColor = [UIColor redColor];
        [self.view addSubview:_locationLab];
    }
}

#pragma mark - 代理方法

//按下return键回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [_userNameTextField resignFirstResponder];
    return YES;
}

// 拍照完成后回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    /* 参数info是一个字典
     UIImagePickerControllerMediaType; // 媒体类型
     UIImagePickerControllerOriginalImage; // 原始图片
     UIImagePickerControllerEditedImage; // 裁剪后图片
     UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     UIImagePickerControllerMediaURL; // 媒体的URL
     UIImagePickerControllerReferenceURL // 原件的URL
     UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 从info中将图片取出，并加载到headImageView当中
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        self.headImageView.image = image;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//进行授权选择后调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        {
            if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [self.locationManager requestWhenInUseAuthorization];
            }
        }
            break;
        default:
            break;
    }
}

//返回位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D Coordinate = newLocation.coordinate;
    NSLog(@"经度：%f,纬度：%f",Coordinate.longitude,Coordinate.latitude);
    [manager stopUpdatingLocation];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark *place in placemarks) {
            NSLog(@"======================name,%@",place.name);// 位置名
            NSLog(@"街道,%@",place.thoroughfare);               // 街道
            NSLog(@"子街道,%@",place.subThoroughfare);          // 子街道
            NSLog(@"市,%@",place.locality);                    // 市
            NSLog(@"区,%@",place.subLocality);                 // 区
            NSLog(@"国家,%@",place.country);                   // 国家
            self.locationLab.text = [NSString stringWithFormat:@"%@%@%@", @"欢迎你,来自",place.locality,@"的朋友"];
        }
    }];
}

#pragma mark -- 其他方法

-(void)startLocation {
    if (!_locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 100.0f;
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined) {
                //在前台定位,requestAlwaysAuthorization后台也可以定位
                [_locationManager requestWhenInUseAuthorization];
            }
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
                //9以后：临时开打后台定位功能
                _locationManager.allowsBackgroundLocationUpdates =YES;
            }
        }
        [self.locationManager startUpdatingLocation];
    }
}

- (void)headClick {
    if (!_imagePicker) {
        _imagePicker= [[UIImagePickerController alloc] init];
        // 设置代理
        _imagePicker.delegate = self;
        // 是否允许编辑（默认为NO）
        _imagePicker.allowsEditing = YES;
        //后置摄像头
        _imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        //跳转动画效果
        _imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    }
    UIAlertController *alertController =[[UIAlertController alloc] init];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *camera =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *pgotoGraph =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoGraph];
    }];
    [alertController addAction:cancel];
    [alertController addAction:camera];
    [alertController addAction:pgotoGraph];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)startJump:(id)sender {
    ShowViewController *showViewController =[[ShowViewController alloc] init];
    if (self.userNameTextField.text.length!=0 && self.userNameTextField.text.length!=0 && self.provincePicker.text.length!=0) {
        showViewController.name = self.userNameTextField.text;
        showViewController.birthday = self.birthdayPicker.text;
        showViewController.province = self.provincePicker.text;
        [self.navigationController pushViewController:showViewController animated:YES];
    } else {
        [self popUpPrompt:@"还有选项未填写"];
    }
}

- (void)openCamera {
    //判断是否可以打开照相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //摄像头
        _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_imagePicker animated:YES completion:nil];
    } else {
        [self popUpPrompt:@"没有检测到相机"];
    }
}

- (void)popUpPrompt:(NSString *)promptStr {
    self.HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.HUD.mode = MBProgressHUDModeText;
    self.HUD.label.text = promptStr;
    //HUD显示位置
    self.HUD.offset = CGPointMake(0.f, 30.f);
    [self.HUD hideAnimated:YES afterDelay:2.f];
}

//打开相册
-(void)openPhotoGraph {
    /* 进入相册，
     UIImagePickerControllerSourceTypePhotoLibrary,// 图库相簿
     UIImagePickerControllerSourceTypeCamera,// 相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum// 相机胶卷
     */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePicker animated:YES completion:^{
            NSLog(@"打开相册");
        }];
    } else {
        [self popUpPrompt:@"不能打开相册"];
    }
}

-(void)autolayoutFirstView {
    //弱引用表示self用于代码块中，我也不知道为什么
    __weak typeof(self) weakSelf = self;
    
    //Location位置栏布局
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        //上边距离屏幕50px
        make.top.equalTo(weakSelf.view.mas_top).with.offset(50);
        //左边距离30
        make.left.equalTo(weakSelf.view.mas_left).with.offset(30);
        //右边界、底部边界都是负
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-50);
        make.height.equalTo(weakSelf.locationLab.mas_width).multipliedBy(0.2);
    }];
    
    //头像布局
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //头像的上边距离位置lable 50px
        make.top.equalTo(weakSelf.locationLab.mas_bottom).with.offset(30);
        //头像左边对齐
        make.centerX.equalTo(weakSelf.locationLab.mas_centerX);
        //右边界、底部边界都是负
        make.width.equalTo(weakSelf.locationLab.mas_width).multipliedBy(0.5);
        make.height.equalTo(weakSelf.headImageView.mas_width);
    }];
    
    
    //用户名Lable布局
    [self.userNamelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        // make.centerY.equalTo(weakSelf.headImageView.mas_centerY).with.offset(0);
        make.top.equalTo(weakSelf.headImageView.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.locationLab.mas_left);
        //make.right.equalTo(weakSelf.view.mas_right).with.offset(-30);
        make.width.equalTo(weakSelf.headImageView.mas_width).multipliedBy(0.25);
        //高度head一半
        make.height.equalTo(weakSelf.headImageView.mas_height).multipliedBy(0.25);
        
    }];
    
    //   用户名输入框
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.userNamelab.mas_centerY).with.offset(0);
        make.top.equalTo(weakSelf.headImageView.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.userNamelab.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.locationLab).with.offset(0);
        make.height.equalTo(weakSelf.userNamelab.mas_height);
    }];
    
    //生日Lable布局
    [self.birthdaylab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNamelab.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.userNamelab.mas_left);
        make.width.equalTo(weakSelf.userNamelab);
        make.height.equalTo(weakSelf.userNamelab);
    }];
    
    // 生日选择
    [self.birthdayPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.birthdaylab.mas_centerY).with.offset(0);
        //        make.top.equalTo(weakSelf.userNameTextField.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.birthdaylab.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.locationLab.mas_right).with.offset(0);
        //        make.width.equalTo(weakSelf.headImageView.mas_width);
        make.height.equalTo(weakSelf.birthdaylab.mas_height);
    }];
    
    //地区Lable布局
    [self.provincelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.birthdaylab.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.birthdaylab.mas_left);
        make.width.equalTo(weakSelf.birthdaylab);
        make.height.equalTo(weakSelf.birthdaylab);
    }];
    
    //地区选择
    [self.provincePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.provincelab.mas_centerY).with.offset(0);
        make.left.equalTo(weakSelf.provincelab.mas_right).with.offset(5);
        make.right.equalTo(weakSelf.locationLab.mas_right);
        make.height.equalTo(weakSelf.provincelab.mas_height);
        
    }];
    //跳转布局
    [self.signInbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.provincelab.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.provincelab.mas_left).with.offset(30);
        make.width.equalTo(weakSelf.provincelab).multipliedBy(2);
        make.height.equalTo(weakSelf.provincelab).multipliedBy(1.5);
    }];
}

@end
