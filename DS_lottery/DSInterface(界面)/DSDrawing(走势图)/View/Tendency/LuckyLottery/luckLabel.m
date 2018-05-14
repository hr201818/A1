//
//  luckLabel.m
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "luckLabel.h"
#import "Header.h"
@implementation luckLabel

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {

        self.numberOfLines = 0;
        self.textColor = labelTextClor;
        self.textAlignment = NSTextAlignmentCenter;

//        self.layer.borderColor = [UIColor blackColor].CGColor;
//        self.layer.borderWidth = 1;
    }

    return self;
}

@end
