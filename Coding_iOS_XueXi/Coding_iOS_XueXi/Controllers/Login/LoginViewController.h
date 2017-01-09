//
//  LoginViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "Login.h"
#import <TPKeyboardAvoidingTableView.h>

@interface LoginViewController : BaseViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) BOOL showDismissButton;
@end
