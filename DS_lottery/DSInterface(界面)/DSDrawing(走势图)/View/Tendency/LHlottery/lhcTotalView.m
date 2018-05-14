//
//  lhcTotalView.m
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lhcTotalView.h"
#import "Header.h"
#import "luckHeaderView.h"
#import "SerialLabel.h"
#import "LHlotteryView.h"

#import "lhcHeaderView.h"
#import "LiuHeTotalTableViewCell.h"
@interface lhcTotalView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation lhcTotalView

- (id)init {
    self = [super init];
    if (self) {

        [self prepareLayout];
    }

    return self;
}

- (void)prepareLayout {


    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];

    self.myTableView.delegate = self;

    self.myTableView.dataSource = self;

    self.myTableView.allowsSelection = NO;

    self.myTableView.bounces = NO;

    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.myTableView];
    _myTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    LiuHeTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[LiuHeTotalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }

    if (indexPath.row %2 == 0) {
        cell.backgroundColor= backgColor;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    if ([tool arrIsNull:_totalArr]==YES) {
        cell.openCodeArray = _totalArr[indexPath.row];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _issueArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    lhcHeaderView *header = [[lhcHeaderView alloc]initWithFrame:CGRectMake(0, 0, _totalHeaderArr.count * (lhWidthTow), cellHeight*2/3) title:@"总和" content:[NSMutableArray arrayWithArray:_totalHeaderArr]];
    return header;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3;
}
//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

   LHlotteryView *ex = (LHlotteryView *)[[self superview] superview];
    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;


    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {

        ex.myTableView.contentOffset=CGPointZero;
    }
}
@end
