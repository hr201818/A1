//
//  luckRightView.m
//  Ticket
//
//  Created by pro on 2017/7/18.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "luckRightView.h"
#import "Header.h"
#import "luckHeaderView.h"
#import "SerialLabel.h"
#import "LuckyTwentyEightView.h"
#import "rightView.h"
@interface luckRightView ()<UITableViewDelegate,UITableViewDataSource>
{
//   NSMutableArray *_contentArr;//号码表
}
@end
@implementation luckRightView

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
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.top.bottom.equalTo(@0);
    }];

    
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

    rightView *luck = [[rightView alloc]initWithFrame:CGRectMake(0, 0, (cellHeight/2 * _contentArr.count), ScreenW) issue:_issueArr results:_resultsArr number:_numberArr values:_valuesArr maxValuesArr:_maxValuesArr evenValue:_evenValueArr listArr:_contentArr];
    [cell.contentView addSubview:luck];
//    [cell setupAutoHeightWithBottomView:luck bottomMargin:10];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _issueArr.count*cellHeight/2;
//    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[[UIScreen mainScreen] bounds].size.width tableView:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if ([self.playGroupId integerValue]==7) {
        UILabel *ti = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,_contentArr.count * (cellHeight/2), cellHeight*2/3/2)];
        ti.backgroundColor = [UIColor whiteColor];
        ti.text = @"和值分布";
        ti.textAlignment = NSTextAlignmentCenter;
        ti.font = [UIFont zkd_systemFontOfSize:13];
        ti.textColor = labelTextClor;
        return ti;
    }
    else{
        luckHeaderView *header = [[luckHeaderView alloc]initWithFrame:CGRectMake(0, 0, _contentArr.count * (cellHeight/2), cellHeight*2/3) title:@"大区" content:_contentArr];
        return header;
    }


}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.playGroupId integerValue]==7 ? cellHeight*2/3/2 :cellHeight*2/3;
}
//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    LuckyTwentyEightView *ex = (LuckyTwentyEightView *)[[self superview] superview];

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;


    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {

        ex.myTableView.contentOffset=CGPointZero;
    }
}
@end
