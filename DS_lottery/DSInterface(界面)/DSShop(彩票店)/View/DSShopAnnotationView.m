//
//  DSShopAnnotationView.m
//  DS_lottery
//
//  Created by pro on 2018/4/27.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSShopAnnotationView.h"


@implementation DSShopAnnotationView

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.width = 44;
        self.height = 46;
        [self initLayoutView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.width == 0) {
        self.width = 44;
        self.height = 46;
    }
    self.centerOffset = CGPointMake(0, -23);
}

-(void)initLayoutView{
    UIImageView * backImage = [[UIImageView alloc]initWithFrame:CGRectMake(-8, -6, 60, 63)];
    [backImage setImage:[UIImage imageNamed:@"btn_home_people"]];
    [self addSubview:backImage];
    self.headerImg = [[UIImageView alloc]initWithFrame:CGRectMake(3, 1.5, 38, 38)];
    [self addSubview:self.headerImg];
    self.headerImg.clipsToBounds = YES;
    self.headerImg.contentMode = UIViewContentModeScaleAspectFill;
    self.headerImg.layer.masksToBounds = YES;
    self.headerImg.layer.cornerRadius = 19;
}

@end
