//
//  lhcTemaView.m
//  Ticket
//
//  Created by pro on 2017/7/19.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "lhcTemaView.h"
#import "Header.h"
#import "luckHeaderView.h"
#import "LHlotteryView.h"
#import "lhcHeaderView.h"

#import "LiuHeTemaTableViewCell.h"
@interface lhcTemaView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation lhcTemaView
- (id)init {
    self = [super init];
    if (self) {

        [self prepareLayout];
    }

    return self;
}

- (void)prepareLayout {


    self.temaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];

    self.temaTableView.delegate = self;

    self.temaTableView.dataSource = self;

    self.temaTableView.allowsSelection = NO;

    self.temaTableView.bounces = NO;

    self.temaTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.temaTableView.showsVerticalScrollIndicator = NO;
    self.temaTableView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.temaTableView];
    _temaTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));


}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    LiuHeTemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[LiuHeTemaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if (indexPath.row %2 == 0) {
        cell.backgroundColor= backgColor;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if ([tool arrIsNull:_temaArr]==YES) {
        cell.openCodeArray = _temaArr[indexPath.row];
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

    lhcHeaderView *header = [[lhcHeaderView alloc]initWithFrame:CGRectMake(0, 0, _temaHeaderArr.count * (lhWidthThree), cellHeight*2/3) title:@"特码" content:[NSMutableArray arrayWithArray:_temaHeaderArr]];
    return header;

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3;
}
//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    LHlotteryView *ex = (LHlotteryView *)[[self superview] superview];
    CGFloat offsetY = _temaTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;


    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {

        ex.myTableView.contentOffset=CGPointZero;
    }
}
@end
