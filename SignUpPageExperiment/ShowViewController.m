//
//  ShowViewController.m
//  SignUpPageExperiment
//
//  Created by wangtaikun on 2018/8/20.
//  Copyright © 2018年 wangtaikun. All rights reserved.
//

#import "ShowViewController.h"
#import "Masonry.h"

@interface ShowViewController ()

@property(strong, nonatomic) UILabel *nameLabel;
@property(strong, nonatomic) UILabel *birthdayLabel;
@property(strong, nonatomic) UILabel *provinceLabel;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"确认信息"];
    [self initNameLab];
    [self initBirthdayLab];
    [self initProvince];
    [self autoLayoutShowView];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setName:(NSString *)name {
    _name = name;
}

-(void)initNameLab {
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.backgroundColor = [UIColor whiteColor];
    _nameLabel.font = [UIFont systemFontOfSize:20];
    NSString *nameLabStr = @"您的昵称是: ";
    //使用传递的值进行拼接
    _nameLabel.text = [nameLabStr stringByAppendingString:self.name];
    [self.view addSubview:_nameLabel];
}

-(void)initBirthdayLab {
    _birthdayLabel = [[UILabel alloc] init];
    _birthdayLabel.backgroundColor = [UIColor whiteColor];
    _birthdayLabel.font = [UIFont systemFontOfSize:20];
    _birthdayLabel.numberOfLines = 0;
    NSString *birthLabStr = @"您的生日是: ";
    _birthdayLabel.text = [birthLabStr stringByAppendingString:self.birthday];
    [self.view addSubview:_birthdayLabel];
}

-(void)initProvince {
    _provinceLabel = [[UILabel alloc] init];
    _provinceLabel.backgroundColor = [UIColor whiteColor];
    _provinceLabel.font = [UIFont systemFontOfSize:20];
    _provinceLabel.numberOfLines = 0;
    NSString *birthLabStr = @"您的籍贯是: ";
    _provinceLabel.text = [birthLabStr stringByAppendingString:self.province];
    [self.view addSubview:_provinceLabel];
}

-(void)autoLayoutShowView {
    __weak typeof(self) weakSelf = self;
    //昵称
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view.mas_top).with.offset(50);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(30);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-50);
        make.height.equalTo(weakSelf.nameLabel.mas_width).multipliedBy(0.2);
    }];
    
    //生日
    [self.birthdayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nameLabel.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.nameLabel.mas_left);
        make.right.equalTo(weakSelf.nameLabel.mas_right).with.offset(0);
        make.height.equalTo(weakSelf.nameLabel.mas_height);
    }];
    
    //籍贯
    [self.provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.birthdayLabel.mas_bottom).with.offset(30);
        make.left.equalTo(weakSelf.birthdayLabel.mas_left);
        make.width.equalTo(weakSelf.birthdayLabel);
        make.height.equalTo(weakSelf.birthdayLabel);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
