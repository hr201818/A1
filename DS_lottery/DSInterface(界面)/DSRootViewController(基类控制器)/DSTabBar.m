//
//  DSTabBar.m
//  DS_lottery
//
//  Created by pro on 2018/4/7.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSTabBar.h"
#import "DSTabbarItem.h"
@interface DSTabBar(){
    DSTabbarItem * _item_1;
    DSTabbarItem * _item_2;
    DSTabbarItem * _item_3;
    DSTabbarItem * _item_4;
    DSTabbarItem * _item_5;
}

@end

@implementation DSTabBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _item_1 = [[DSTabbarItem alloc]initWithFrame:CGRectMake(0, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT) DefaultImage:[UIImage imageNamed:@"toolbar_icon_xihu-dis"] SelecteImage:[UIImage imageNamed:@"toolbar_icon_xihu-pre"] Title:@"首页"];
        _item_1.imageView.frame = CGRectMake((_item_1.width - 24)/2, 5, 24, 24);
        
        _item_2 = [[DSTabbarItem alloc]initWithFrame:CGRectMake(_item_1.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT) DefaultImage:[UIImage imageNamed:@"toolbar_icon_xiaoguanjia-_dis"] SelecteImage:[UIImage imageNamed:@"toolbar_icon_xiaoguanjia_pre"] Title:@"开奖公告"];
        _item_2.imageView.frame = CGRectMake((_item_2.width - 21.5)/2, 4, 21.5, 26);

        _item_3 = [[DSTabbarItem alloc]initWithFrame:CGRectMake(_item_2.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT) DefaultImage:[UIImage imageNamed:@"toolbar_icon_HI_dis"] SelecteImage:[UIImage imageNamed:@"toolbar_icon_HI-_pre"] Title:@"彩票店"];
        
        _item_4 = [[DSTabbarItem alloc]initWithFrame:CGRectMake(_item_3.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT) DefaultImage:[UIImage imageNamed:@"label_bar_taopiaopiao_normal"] SelecteImage:[UIImage imageNamed:@"label_bar_taopiaopiao_selected"] Title:@"走势图"];
        _item_4.imageView.frame = CGRectMake((_item_4.width - 24)/2, 5, 24, 23);

        _item_5 = [[DSTabbarItem alloc]initWithFrame:CGRectMake(_item_4.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT) DefaultImage:[UIImage imageNamed:@"toolbar_icon_wode_dis"] SelecteImage:[UIImage imageNamed:@"toolbar_icon_wode-_pre"] Title:@"个人中心"];
        _item_5.imageView.frame = CGRectMake((_item_5.width - 19)/2, 6, 19, 21.5);
        _item_1.isSelect = YES;

//        _item_1.frame = CGRectMake(0, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT);
//        _item_2.frame = CGRectMake(_item_1.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT);
//        _item_3.frame = CGRectMake(_item_2.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT);
//        _item_4.frame = CGRectMake(_item_3.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT);
//        _item_5.frame = CGRectMake(_item_4.right, 0, PhoneScreen_WIDTH/5,Tabbar_HEIGHT);
        [self addSubview:_item_1];
        [self addSubview:_item_2];
        [self addSubview:_item_3];
        [self addSubview:_item_4];
        [self addSubview:_item_5];

        for (int i = 0; i<5; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(i*PhoneScreen_WIDTH/5, 0, PhoneScreen_WIDTH/5, Tabbar_HEIGHT);
            [btn addTarget:self action:@selector(itemIndex:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            btn.tag = 1+i;
        }

    }
    return self;
}

-(void)itemIndex:(UIButton*)sender{
    _item_1.isSelect = NO;
    _item_2.isSelect = NO;
    _item_3.isSelect = NO;
    _item_4.isSelect = NO;
    _item_5.isSelect = NO;
    switch (sender.tag) {
        case 1:_item_1.isSelect = YES;break;
        case 2:_item_2.isSelect = YES;break;
        case 3:_item_3.isSelect = YES;break;
        case 4:_item_4.isSelect = YES;break;
        case 5:_item_5.isSelect = YES;break;
        default:
            break;
    }
    if(self.selectBlock){
        self.selectBlock(sender.tag-1);
    }
}

/* 外部执行调用 */
-(void)selectIndex:(NSInteger)index{
    _item_1.isSelect = NO;
    _item_2.isSelect = NO;
    _item_3.isSelect = NO;
    _item_4.isSelect = NO;
    _item_5.isSelect = NO;
    switch (index + 1) {
        case 1:_item_1.isSelect = YES;break;
        case 2:_item_2.isSelect = YES;break;
        case 3:_item_3.isSelect = YES;break;
        case 4:_item_4.isSelect = YES;break;
        case 5:_item_5.isSelect = YES;break;
        default:
            break;
    }
    if(self.selectBlock){
        self.selectBlock(index);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //防止原生的按钮挡住当前自定义的按钮
     Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.hidden = YES;
        }
    }
}

//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    if (self.isHidden == NO) {
//            //将当前tabbar的触摸点转换坐标系，转换到中间按钮的身上，生成一个新的点
//            CGPoint newP = [self convertPoint:point toView:self.centerBtn];
//            //判断如果这个新的点是在中间按钮身上，那么处理点击事件最合适的view就是中间按钮
//            if ( [self.centerBtn pointInside:newP withEvent:event]) {
//                return self.centerBtn;
//            }
//    }
//    return [super hitTest:point withEvent:event];
//}





@end
