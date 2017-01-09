//
//  Input_OnlyText_Cell.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#define kCellIdentifier_Input_OnlyText_Cell_Text @"Input_OnlyText_Cell_Text"
#define kCellIdentifier_Input_OnlyText_Cell_Captcha @"Input_OnlyText_Cell_Captcha"
#define kCellIdentifier_Input_OnlyText_Cell_Password @"Input_OnlyText_Cell_Password"
#define kCellIdentifier_Input_OnlyText_Cell_Phone @"Input_OnlyText_Cell_Phone"


#import <UIKit/UIKit.h>
#import "PhoneCodeButton.h"
#import "UITapImageView.h"

@interface Input_OnlyText_Cell : UITableViewCell
@property (nonatomic, strong, readonly) UITextField *textField;
@property (nonatomic, strong) UILabel *countryCodeL;
@property (nonatomic, strong, readonly) PhoneCodeButton *verify_codeBtn;

@property (nonatomic, assign) BOOL isForLoginVC;

@property (nonatomic, copy) void (^textValueChangedBlock)(NSString *);
@property (nonatomic, copy) void (^editDidBeginBlock)(NSString *);
@property (nonatomic, copy) void (^editDidEndBlock)(NSString *);
@property (nonatomic,copy) void(^phoneCodeBtnClckedBlock)(PhoneCodeButton *);
@property (nonatomic,copy) void(^countryCodeBtnClickedBlock)();

- (void)setPlaceholder:(NSString *)phStr value:(NSString *)valueStr;

+ (NSString *)randomCellIdentifierOfPhoneCodeType;
@end
