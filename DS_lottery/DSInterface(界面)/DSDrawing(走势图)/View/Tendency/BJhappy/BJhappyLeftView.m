//
//  BJhappyLeftView.m
//  Ticket
//
//  Created by pro on 2017/7/17.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "BJhappyLeftView.h"
#import "Header.h"
#import "LuckyTwentyEightView.h"
@interface BJhappyLeftView ()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation BJhappyLeftView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {

        [self prepareLayout];
    }

    return self;
}

- (void)prepareLayout {

    _leftTableView =[[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.tableFooterView = [UIView new];
    _leftTableView.bounces = NO;
    _leftTableView.allowsSelection = NO;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.showsHorizontalScrollIndicator = NO;
    _leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_leftTableView];
    _leftTableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    if (indexPath.row%2==0) {
        cell.backgroundColor = backgColor;

    }else{
        cell.backgroundColor =[UIColor whiteColor];
    }

    UILabel*_label = [[UILabel alloc]init];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont zkd_systemFontOfSize:13];
    _label.text = [NSString stringWithFormat:@"%@",self.leftDataArray[indexPath.row]];
    _label.textColor = labelTextClor;
    if ([tool includeChinese:_label.text]) {
        _label.textColor = [Helper getTrendTextColor:indexPath.row arrCount:self.leftDataArray.count];
    }
    
    [cell.contentView addSubview:_label];
    _label.sd_layout.leftSpaceToView(cell.contentView,0).topSpaceToView(cell.contentView, 0).rightSpaceToView(cell.contentView, 0).heightIs(_isLH == NO ? cellHeight/2:cellHeight*2/2);

    [cell setupAutoHeightWithBottomView:_label bottomMargin:0];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView cellHeightForIndexPath:indexPath cellContentViewWidth:[[UIScreen mainScreen] bounds].size.width tableView:tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftDataArray.count;
}

//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {


    LuckyTwentyEightView *ex = (LuckyTwentyEightView *)[self superview];

    CGFloat offsetY = _leftTableView.contentOffset.y;

    CGPoint timeOffsetY = ex.myTableView.contentOffset;
    timeOffsetY.y = offsetY;

    ex.myTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {
        ex.myTableView.contentOffset=CGPointZero;
    }
}



@end
