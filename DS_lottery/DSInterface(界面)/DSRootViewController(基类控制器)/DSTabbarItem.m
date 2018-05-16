//
//  DSTabbarItem.m
//  DS_lottery
//
//  Created by pro on 2018/4/8.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSTabbarItem.h"
@interface DSTabbarItem()

@property (strong, nonatomic) UILabel     * titleName;

@property (strong, nonatomic) UIImage     * defaultimage;

@property (strong, nonatomic) UIImage     * selecteImage;

@end

@implementation DSTabbarItem

- (instancetype)initWithFrame:(CGRect)frame DefaultImage:(UIImage *)defaultimage SelecteImage:(UIImage *)selecteImage Title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        _selecteImage = selecteImage;
        _defaultimage = defaultimage;
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.width - 28)/2, 2, 28, 28)];
        [self.imageView setImage:_defaultimage];
        [self addSubview:self.imageView];
//        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(@0);
//            make.height.and.width.equalTo(@28);
//            make.top.equalTo(@2);
//        }];
        self.titleName = [[UILabel alloc]init];
        self.titleName.font = [UIFont systemFontOfSize:11];
        self.titleName.textColor = [UIColor grayColor];
        self.titleName.textAlignment = NSTextAlignmentCenter;
        self.titleName.text = title;
        [self addSubview:self.titleName];
        [self.titleName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@0);
            make.right.equalTo(@0);
            make.height.equalTo(@19);
            make.bottom.equalTo(@(-Tabbarbottom_HEIGHT));
        }];
        _isSelect = NO;
    }
    return self;
}



-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if(_isSelect){
        self.titleName.textColor = COLOR_HOME;
        [self.imageView setImage:_selecteImage];
    }else{
        self.titleName.textColor = [UIColor grayColor];
        [self.imageView setImage:_defaultimage];
    }
}

@end
