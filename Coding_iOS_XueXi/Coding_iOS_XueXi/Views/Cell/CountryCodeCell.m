//
//  CountryCodeCell.m
//  Coding_iOS_XueXi
//
//  Created by apple on 17/3/28.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CountryCodeCell.h"

@interface CountryCodeCell()
@property (nonatomic, strong) UILabel *leftL;
@property (strong, nonatomic) UILabel *rightL;

@end

@implementation CountryCodeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _leftL = ({
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = kColor222;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(kPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
            label;
        });
        
        _rightL = ({
            UILabel *label = [UILabel new];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = kColor999;
            [self.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.contentView).offset(-kPaddingLeftWidth);
                make.centerY.equalTo(self.contentView);
            }];
            label;
        });
    }
    
    return self;
}

- (void)setCountryCodeDict:(NSDictionary *)countryCodeDict {
    _countryCodeDict = countryCodeDict;
    _leftL.text = _countryCodeDict[@"country"];
    _rightL.text = [NSString stringWithFormat:@"+%@", [_countryCodeDict objectForKey:@"country_code"]];
}


@end
