//
//  LoginViewController.m
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "Input_OnlyText_Cell.h"
#import "Login2FATipCell.h"
#import "Coding_NetAPIManager.h"
#import "EaseInputTipsView.h"
#import "StartImagesManager.h"
#import <NYXImagesKit/NYXImagesKit.h>
#import <UIImage+BlurredFrame/UIImage+BlurredFrame.h>
#import "AppDelegate.h"
#import "RegisterViewController.h"
#import "CannotLoginViewController.h"

@interface LoginViewController ()
@property (nonatomic, strong) Login *myLogin;

@property (nonatomic, strong) TPKeyboardAvoidingTableView *myTableView;
@property (nonatomic, strong) UIView *bottomView;

@property (assign, nonatomic) BOOL captchaNeeded;
@property (nonatomic, strong) UIImageView *bgBlurredView, *iconUserView;
@property (nonatomic, strong) UIButton *dismissButton;
@property (strong, nonatomic) UIButton *loginBtn, *buttonFor2FA, *cannotLoginBtn;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) EaseInputTipsView *inputTipsView;

@property (assign, nonatomic) BOOL is2FAUI;
@property (strong, nonatomic) NSString *otpCode;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLogin = [[Login alloc] init];
    self.myLogin.email = [Login preUserEmail];
    _captchaNeeded = NO;
    
    //    添加myTableView
    _myTableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [tableView registerClass:[Login2FATipCell class] forCellReuseIdentifier:kCellIdentifier_Login2FATipCell];
        [tableView registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Text];
        [tableView registerClass:[Input_OnlyText_Cell class] forCellReuseIdentifier:kCellIdentifier_Input_OnlyText_Cell_Captcha];
        
        tableView.backgroundView = self.bgBlurredView;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        
        tableView;
    });
    
    self.myTableView.tableHeaderView = [self customHeaderView];
    self.myTableView.tableFooterView = [self customFooterView];
    [self configBottomView];
    [self showdismissButton:self.showDismissButton];
    [self buttonFor2FA];
    [self refreshCaptchaNeeded];
    [self refreshIconUserImage];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!_inputTipsView) {
        _inputTipsView = ({
            EaseInputTipsView *tipsView = [EaseInputTipsView tipsViewWithType:EaseInputTipsViewTypeLogin];
            tipsView.valueStr = nil;
            
            __weak typeof(self) weakSelf = self;
            tipsView.selectedStringBlock = ^(NSString *valueStr){
                [weakSelf.view endEditing:YES];
                weakSelf.myLogin.email = valueStr;
                [weakSelf refreshIconUserImage];
                [weakSelf.myTableView reloadData];
            };
            tipsView;
        });
    }
}

- (UIButton *)buttonFor2FA {
    if (!_buttonFor2FA) {
        _buttonFor2FA = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_Width - 100, 20, 90, 50)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateHighlighted];
            [button setTitle:@"  两步验证" forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"twoFABtn_Nav"] forState:UIControlStateNormal];
            button;
        });
        
        [_buttonFor2FA addTarget:self action:@selector(goTo2FAVC) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_buttonFor2FA];
    }
    
    return _buttonFor2FA;
}

- (void)showdismissButton:(BOOL)willShow {
    self.dismissButton.hidden = !willShow;
    if (!self.dismissButton && willShow) {
        self.dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 50, 50)];
        [self.dismissButton setImage:[UIImage imageNamed:@"dismissBtn_Nav"] forState:UIControlStateNormal];
        [self.dismissButton addTarget:self action:@selector(dismissButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.dismissButton];
    }
}

- (UIImageView *)bgBlurredView {
    if (!_bgBlurredView) {
        //背景图片
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:kScreen_Bounds];
        bgView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *bgImage = [[StartImagesManager shareManager] curImage].image;
        
        CGSize bgImageSize = bgImage.size, bgViewSize = bgView.frame.size;
        if (bgImageSize.width > bgViewSize.width && bgImageSize.height > bgViewSize.height) {
            bgImage = [bgImage scaleToSize:bgViewSize usingMode:NYXResizeModeAspectFill];
        }
        bgImage = [bgImage applyLightEffectAtFrame:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
        bgView.image = bgImage;

        //黑色遮罩
        UIColor *blackColor = [UIColor blackColor];
        [bgView addGradientLayerWithColors:@[(id)[blackColor colorWithAlphaComponent:0.3].CGColor,
                                             (id)[blackColor colorWithAlphaComponent:0.3].CGColor]
                                 locations:nil
                                startPoint:CGPointMake(0.5, 0.0) endPoint:CGPointMake(0.5, 1.0)];
        _bgBlurredView = bgView;
    }
    return _bgBlurredView;
}

- (void)refreshCaptchaNeeded {
    __weak typeof(self) weakSelf = self;
    [[Coding_NetAPIManager sharedManager] request_CaptchaNeededWithPath:@"api/captcha/login" andBlock:^(id data, NSError *error) {
        if (data) {
            NSNumber *captchaNeededResult = (NSNumber *)data;
            if (captchaNeededResult) {
                weakSelf.captchaNeeded = captchaNeededResult.boolValue;
            }
            [weakSelf.myTableView reloadData];
        }
    }];
}

- (void)refreshIconUserImage {
    NSString *textStr = self.myLogin.email;
    if (textStr) {
        User *curUser = [Login userWithGlobaykeyOrEmail:textStr];
        if (curUser && curUser.avatar) {
            [self.iconUserView sd_setImageWithURL:[curUser.avatar urlImageWithCodePathResizeToView:self.iconUserView] placeholderImage:[UIImage imageNamed:@"icon_user_monkey"]];
            return;
        }
    }
    [self.iconUserView setImage:[UIImage imageNamed:@"icon_user_monkey"]];
}


#pragma mark - Table view Header Footer

- (UIView *)customHeaderView {
    CGFloat iconUserViewWidth;
    if (kDevice_Is_iPhone6Plus) {
        iconUserViewWidth = 100;
    }else if (kDevice_Is_iPhone6) {
        iconUserViewWidth = 90;
    }else {
        iconUserViewWidth = 75;
    }
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height/3)];
    _iconUserView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, iconUserViewWidth, iconUserViewWidth)];
    _iconUserView.contentMode = UIViewContentModeScaleAspectFit;
    _iconUserView.layer.masksToBounds = YES;
    _iconUserView.layer.cornerRadius = _iconUserView.frame.size.width/2;
    _iconUserView.layer.borderWidth = 2;
    _iconUserView.layer.borderColor = [UIColor whiteColor].CGColor;

    [headerV addSubview:_iconUserView];
    [_iconUserView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(iconUserViewWidth, iconUserViewWidth));
        make.centerX.equalTo(headerV);
        make.centerY.equalTo(headerV).offset(30);
    }];
    
    [_iconUserView setImage:[UIImage imageNamed:@"icon_user_monkey"]];
    return headerV;
}

- (UIView *)customFooterView {
    
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 150)];
    _loginBtn = [UIButton buttonWithStyle:StrapSuccessStyle andTitle:@"登录" andFrame:CGRectMake(kLoginPaddingLeftWidth, 20, kScreen_Width-kLoginPaddingLeftWidth*2, 45) target:self action:@selector(sendLogin)];
    [footerV addSubview:_loginBtn];
    
    RAC(self, loginBtn.enabled) = [RACSignal combineLatest:@[RACObserve(self, myLogin.email),
                                                             RACObserve(self, myLogin.password),
                                                             RACObserve(self, myLogin.j_captcha),
                                                             RACObserve(self, captchaNeeded),
                                                             RACObserve(self, is2FAUI),
                                                             RACObserve(self, otpCode)]
                                                    reduce:^id(NSString *email,
                                                               NSString *password,
                                                               NSString *j_captcha,
                                                               NSNumber *captchaNeeded,
                                                               NSNumber *is2FAUI,
                                                               NSString *otpCode){
                                                        if (is2FAUI && is2FAUI.boolValue) {
                                                            return @(otpCode.length > 0);
                                                        }else{
                                                            if ((captchaNeeded && captchaNeeded.boolValue) && (!j_captcha || j_captcha.length <= 0)) {
                                                                return @(NO);
                                                            }else{
                                                                return @((email && email.length > 0) && (password && password.length > 0));
                                                            }
                                                        }
                                                    }];
    
    _cannotLoginBtn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
        
        [button setTitle:@"找回密码" forState:UIControlStateNormal];
        [footerV addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(footerV);
            make.top.equalTo(_loginBtn.mas_bottom).offset(20);
        }];
        button;
    });
    
    [_cannotLoginBtn addTarget:self action:@selector(cannotLoginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return footerV;
}


#pragma mark BottomView

- (void)configBottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height - 55, kScreen_Width, 55)];
        _bottomView.backgroundColor = [UIColor clearColor];
        UIButton *registerBtn = ({
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [button setTitleColor:[UIColor colorWithWhite:1.0 alpha:0.5] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithWhite:0.5 alpha:0.5] forState:UIControlStateHighlighted];
            
            [button setTitle:@"去注册" forState:UIControlStateNormal];
            [_bottomView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(100, 30));
                make.centerX.equalTo(_bottomView);
                make.top.equalTo(_bottomView);
            }];
            button;
        });
        
        [registerBtn addTarget:self action:@selector(goRegisterVC:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_bottomView];
    }
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _is2FAUI? 2: _captchaNeeded? 3: 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.is2FAUI && indexPath.row == 0) {
        Login2FATipCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Login2FATipCell forIndexPath:indexPath];
        cell.tipLabel.text = @"  您的账户开启了两步验证，请输入动态验证码登录  ";
        return cell;
    }
    
    
    Input_OnlyText_Cell *cell = [tableView dequeueReusableCellWithIdentifier:(indexPath.row > 1? kCellIdentifier_Input_OnlyText_Cell_Captcha: kCellIdentifier_Input_OnlyText_Cell_Text) forIndexPath:indexPath];
    cell.isForLoginVC = YES;
    
    __weak typeof(self) weakSelf = self;
    if (self.is2FAUI) {
        cell.textField.keyboardType = UIKeyboardTypeNumberPad;
        [cell setPlaceholder:@" 动态验证码" value:self.otpCode];
        cell.textValueChangedBlock = ^(NSString *valueStr) {
            weakSelf.otpCode = valueStr;
        };
    }else {
        
        if (indexPath.row == 0) {
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
            [cell setPlaceholder:@" 手机号码/电子邮箱/个性后缀" value:self.myLogin.email];
            cell.textValueChangedBlock = ^(NSString *valueStr) {
                weakSelf.inputTipsView.valueStr = valueStr;
                weakSelf.inputTipsView.active = YES;
                weakSelf.myLogin.email = valueStr;
                [weakSelf refreshIconUserImage];
            };
            
            cell.editDidBeginBlock = ^(NSString *valueStr){
                weakSelf.inputTipsView.valueStr = valueStr;
                weakSelf.inputTipsView.active = YES;
            };

            cell.editDidEndBlock = ^(NSString *textStr) {
                weakSelf.inputTipsView.active = NO;
            };
            
        }else if (indexPath.row == 1) {
            [cell setPlaceholder:@" 密码" value:self.myLogin.password];
            cell.textField.secureTextEntry = YES;
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myLogin.password = valueStr;
            };
        }else {
            [cell setPlaceholder:@" 验证码" value:self.myLogin.j_captcha];
            cell.textValueChangedBlock = ^(NSString *valueStr){
                weakSelf.myLogin.j_captcha = valueStr;
            };
        }
    }
    
    return cell;
}



#pragma mark Btn Clicked

- (void)cannotLoginBtnClicked:(id)sender {
    UIViewController *vc;
    if (_is2FAUI) {
        
    }else {
        vc = [CannotLoginViewController vcWithMethodType:CannotLoginMethodEamil stepIndex:0 userStr:(([self.myLogin.email isPhoneNo] || [self.myLogin.email isEmail])? self.myLogin.email: nil)];
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)sendLogin {
    NSString *tipMsg = self.is2FAUI? [self loginTipFor2FA] : [_myLogin goToLoginTipWithCaptcha:_captchaNeeded];
    if (tipMsg) {
        kTipAlert(@"%@", tipMsg);
        return;
    }
    
    [self.view endEditing:YES];
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        CGSize captchaViewSize = _loginBtn.bounds.size;
        _activityIndicator.hidesWhenStopped = YES;
        [_activityIndicator setCenter:CGPointMake(captchaViewSize.width / 2, captchaViewSize.height / 2)];
        [_loginBtn addSubview:_activityIndicator];
    }
    
    [_activityIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    _loginBtn.enabled = NO;
    
    if (self.is2FAUI) {
        [[Coding_NetAPIManager sharedManager] request_Login_With2FA:self.otpCode andBlock:^(id data, NSError *error) {
            weakSelf.loginBtn.enabled = YES;
            [weakSelf.activityIndicator stopAnimating];
            if (data) {
                [Login setPreUserEmail:self.myLogin.email]; //记住登录账号
                [(AppDelegate *)[UIApplication sharedApplication].delegate setupTabViewController];
            }else {
                NSString *status_expired = error.userInfo[@"msg"][@"user_login_status_expired"];
                if (status_expired.length > 0) {
                    [weakSelf changeUITo2FAWithGK:nil];
                }
            }
        }];
    }else {
        [[Coding_NetAPIManager sharedManager] request_Login_WithPath:self.myLogin.toPath Params:self.myLogin.toParams andBlock:^(id data, NSError *error) {
            weakSelf.loginBtn.enabled = YES;
            [weakSelf.activityIndicator stopAnimating];
            if (data) {
                [Login setPreUserEmail:self.myLogin.email];//记住登录账号
                [((AppDelegate *)[UIApplication sharedApplication].delegate) setupTabViewController];
                [self doSomethingAfterLogin];
            }else {
                NSString *global_key = error.userInfo[@"msg"][@"two_factor_auth_code_not_empty"];
                if (global_key.length > 0) {
                    [weakSelf changeUITo2FAWithGK:global_key];
                }else if (error.userInfo[@"msg"][@"user_need_activate"]) {
                    [NSObject showError:error];
                }else {
                    [NSObject showError:error];
                    [weakSelf refreshCaptchaNeeded];
                }
            }
        }];
    }
    
}


- (void)doSomethingAfterLogin {
    User *curUser = [Login curLoginUser];
    if (curUser.email.length && !curUser.email_validation.boolValue) {
        UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"激活邮箱" message:@"该邮箱尚未激活，请尽快去邮箱查收邮件并激活账号。如果在收件箱中没有看到，请留意一下垃圾邮件箱子（T_T）"];
        [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
        [alertView bk_addButtonWithTitle:@"重发激活邮件" handler:nil];
        [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
            if (index == 1) {
                [self sendActivateEmail];
            }
        }];
        [alertView show];
    }
}


- (void)sendActivateEmail {
    [[Coding_NetAPIManager sharedManager] request_SendActivateEmail:[Login curLoginUser].email block:^(id data, NSError *error) {
        if (data) {
            [NSObject showHudTipStr:@"邮件已发送"];
        }
    }];
}

- (void)dismissButtonClicked {
    if (self.is2FAUI) {
        self.is2FAUI = NO;
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)goRegisterVC:(id)sender {
    RegisterViewController *vc = [RegisterViewController vcWithMethodType:RegisterMethodPhone registerObj:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 2FA

- (void)changeUITo2FAWithGK:(NSString *)global_key {

}


- (NSString *)loginTipFor2FA {
    NSString *tipStr = nil;
    if (self.otpCode.length <= 0) {
        tipStr = @"动态验证码不能为空";
    }else if (![self.otpCode isPureInt] || self.otpCode.length != 6) {
        tipStr = @"动态验证码必须是一个6位数字";
    }
    return tipStr;
}


@end
