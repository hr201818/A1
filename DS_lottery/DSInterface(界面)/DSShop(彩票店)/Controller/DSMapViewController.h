//
//  DSMapViewController.h
//  DS_lottery
//
//  Created by pro on 2018/4/27.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface DSMapViewController : BaseViewController

@property (assign, nonatomic) CGFloat    latitude;
@property (assign, nonatomic) CGFloat    longitude;
@property (copy, nonatomic)   NSString * imageUrl;
@property (copy, nonatomic)   NSString * typeName;

@property (copy, nonatomic)   NSString * hudText;
@end
