//
//  luckNewRightView.m
//  Ticket
//
//  Created by pro on 2017/9/5.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "luckNewRightView.h"
#import "Header.h"
#import "Header.h"
#import "luckHeaderView.h"
#import "luckView.h"
#import "LuckyLotteryView.h"
#import "SerialLabel.h"
@interface luckNewRightView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_contentArr;//号码表
}
@end
@implementation luckNewRightView

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    luckView *luck = [[luckView alloc]initWithFrame:CGRectMake(0, 0, (cellHeight/2 * _contentArr.count), ScreenW) issue:_issueArr results:_resultsArr number:_numberArr values:_valuesArr maxValuesArr:_maxValuesArr evenValue:_evenValueArr listArr:_contentArr latticeWidth:cellHeight/2 latticeHight:cellHeight/2];
    [cell.contentView addSubview:luck];
   // [cell setupAutoHeightWithBottomView:luck bottomMargin:0];

    return cell;
}
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *cellStr = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
//    if (cell ==nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
//    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
////    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    while ([cell.contentView.subviews lastObject] != nil) {
//        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//    }
//    if (indexPath.row%2==0) {
//        cell.backgroundColor = backgColor;
//
//    }else{
//        cell.backgroundColor =[UIColor whiteColor];
//    }
//
//    for (int i = 0; i < _contentArr.count; i++) {
//
//        SerialLabel *headView=[[SerialLabel alloc]initWithFrame:CGRectMake(i * (cellHeight/2), 0, cellHeight/2, cellHeight/2)];
//
//        if (indexPath.row<_issueArr.count-4) {
//            NSString *numberStr = [NSString stringWithFormat:@"%@",_contentArr[i]];
//            headView.label.text = numberStr;
//
//            if ([tool nsArrIsNull:_resultsArr]) {
//
//                if ([self.playGroupId integerValue]==7) {
//                    if ([_resultsArr[indexPath.row] integerValue]==[_contentArr[i] integerValue]) {
//                        headView.selectText = [NSString stringWithFormat:@"%@",_resultsArr[indexPath.row]];
//                    }
//                }else{
//                    NSArray *aa = _resultsArr[indexPath.row];
//                    for (NSString *num in aa) {
//                        if ([num integerValue]==[_contentArr[i] integerValue]) {
//                            headView.selectText = [NSString stringWithFormat:@"%@",num];
//                        }
//                    }
//                }
//
//            }
//
//
//        }
//        else if (indexPath.row==_issueArr.count-4){
//            headView.label.text =  [NSString stringWithFormat:@"%@",_numberArr[i]];
//        }else if (indexPath.row==_issueArr.count-3){
//            headView.label.text =  [NSString stringWithFormat:@"%@",_valuesArr[i]];
//        }else if (indexPath.row==_issueArr.count-2){
//            headView.label.text =  [NSString stringWithFormat:@"%@",_maxValuesArr[i]];
//        }else if (indexPath.row==_issueArr.count-1){
//            headView.label.text =  [NSString stringWithFormat:@"%@",_evenValueArr[i]];
//        }
//
//        [cell.contentView addSubview:headView];
//        [cell setupAutoHeightWithBottomView:headView bottomMargin:0];
//    }
//    return cell;
//}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _issueArr.count*cellHeight/2;
 //   return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[[UIScreen mainScreen] bounds].size.width tableView:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.issueArr.count;
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    luckHeaderView *header = [[luckHeaderView alloc]initWithFrame:CGRectMake(0, 0, _contentArr.count * (cellHeight/2), cellHeight*2/3) title:@"大区" content:_contentArr];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.playGroupId integerValue]==7 ? cellHeight*2/3/2 :cellHeight*2/3;
}
//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    LuckyLotteryView *ex = (LuckyLotteryView *)[[self superview] superview];

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;


    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {

        ex.myTableView.contentOffset=CGPointZero;
    }
}
-(void)setResultsArr:(NSMutableArray *)resultsArr{
    _resultsArr =resultsArr;
}
@end
