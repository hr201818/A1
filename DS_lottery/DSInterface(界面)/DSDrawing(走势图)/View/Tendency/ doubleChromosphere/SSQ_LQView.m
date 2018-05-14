//
//  SSQ_LQView.m
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "SSQ_LQView.h"
#import "SSQ_HQView.h"
#import "Header.h"
#import "SSQBaseClass.h"
#import "SSQHQTableViewCell.h"
#import "TotUpTableViewCell.h"
@interface SSQ_LQView ()<UITableViewDelegate,UITableViewDataSource>{

}
@end
@implementation SSQ_LQView
- (instancetype)init
{
    self = [super init];
    if (self) {

        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];

        _myTableView.delegate = self;

        _myTableView.dataSource = self;

        _myTableView.allowsSelection = NO;
        _myTableView.bounces = NO;

        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_myTableView];
        _myTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row<_issueArr.count-4) {
        static NSString *cellStr = @"cell";
        SSQHQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[SSQHQTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr contentArr:_contentArr];
        }
        if (indexPath.row %2 == 0) {
            cell.backgroundColor= backgColor;
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }
        if (indexPath.row<_issueArr.count-4) {
            if ([tool arrIsNull:_resultsArr]==YES) {
                cell.TotUpArray = _resultsArr[indexPath.row];
            }
        }
        return cell;

    }else{

        static NSString *cellStr = @"totcell";
        TotUpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (cell ==nil) {
            cell = [[TotUpTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr contentArr:_contentArr];
        }
        if (indexPath.row %2 == 0) {
            cell.backgroundColor= backgColor;
        }else{
            cell.backgroundColor = [UIColor whiteColor];
        }

        if (indexPath.row==_issueArr.count-4){
            if ([tool arrIsNull:_numberArr]==YES) {
//                cell.openCodeArray = _numberArr;
                [cell setopenCodeArray:_numberArr index:0];
            }
        }else if (indexPath.row==_issueArr.count-3){
            if ([tool arrIsNull:_valuesArr]==YES) {
//                cell.openCodeArray = _valuesArr;
                [cell setopenCodeArray:_valuesArr index:1];
            }
        }else if (indexPath.row==_issueArr.count-2){
            if ([tool arrIsNull:_maxValuesArr]==YES) {
//                cell.openCodeArray = _maxValuesArr;
                [cell setopenCodeArray:_maxValuesArr index:2];
            }
        }else if (indexPath.row==_issueArr.count-1){
            if ([tool arrIsNull:_evenValueArr]==YES) {
//                cell.openCodeArray = _evenValueArr;
                [cell setopenCodeArray:_evenValueArr index:3];
            }
        }
        return cell;
    }

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *ti = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,_contentArr.count * (cellHeight/2), cellHeight*2/3/2)];
    ti.backgroundColor = [UIColor whiteColor];
    ti.text = @"蓝球";
    ti.textAlignment = NSTextAlignmentCenter;
    ti.font = [UIFont zkd_systemFontOfSize:13];
    ti.textColor = labelTextClor;
    return ti;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight/2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _issueArr.count;
}

//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    SSQ_HQView *ex = (SSQ_HQView *)[[self superview] superview];

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;


    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {

        ex.myTableView.contentOffset=CGPointZero;
    }
}
@end
