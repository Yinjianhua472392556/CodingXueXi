//
//  CountryCodeListViewController.h
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface CountryCodeListViewController : BaseViewController
@property (nonatomic, copy) void (^selectedBlock)(NSDictionary *countryCodeDict);//country, country_code, iso_code
@end
