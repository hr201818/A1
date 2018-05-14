//
//  LuckyTwentyEightView.m
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LuckyTwentyEightView.h"
#import "Header.h"
#import "LuckyTwentyEightBaseClass.h"
#import "luckRightView.h"
#import "BJhappyLeftView.h"
#import "luckBaseClass.h"
#import "lotteryNper.h"
#import "DSDrawingViewController.h"
#import "SerialLabel.h"
#import "luckView.h"
#import "nper.h"
@interface LuckyTwentyEightView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_contentArr;
    NSMutableArray *_rightContentArr;
    lotteryNper *n;

}
@property (nonatomic,copy)NSString *pageSize;
@property (nonatomic,copy)NSString *cacheKey;
@property (nonatomic, strong) luckRightView *rightView;
//@property (nonatomic,strong) YYCache *yyCache;//缓存
@property (nonatomic, strong) BJhappyLeftView *leftView;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *numberArr;//总次数
@property (nonatomic,strong)NSMutableArray *valuesArr;//平均遗漏值
@property (nonatomic,strong)NSMutableArray *maxValuesArr;//最大遗漏值
@property (nonatomic,strong)NSMutableArray *evenValueArr;//连出值
@end


@implementation LuckyTwentyEightView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr rightContentArr:(NSMutableArray *)rightContentArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
      
        self.cacheKey=[NSString stringWithFormat:@"playGroupId%@",playGroupId];
        _contentArr = [NSMutableArray arrayWithArray:contentArr];
        _rightContentArr = [NSMutableArray arrayWithArray:rightContentArr];
        self.nperTag = 0;
        __weak __typeof(self) weakSelf = self;
//        _yyCache=[YYCache cacheWithName:@"zoushiCache"];

//        n = [[lotteryNper alloc]initWithFrame:CGRectMake(0,5, ScreenW, 40)];
//        n.backgroundColor =[UIColor whiteColor];
//        [self addSubview:n];
//        [n lotterNperBtnBlock:^(NSInteger btnTag) {
//            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
//            if ([weakSelf.yyCache containsObjectForKey:_cacheKey]==YES) {
//                [weakSelf.yyCache objectForKey:_cacheKey withBlock:^(NSString * _Nonnull key, id object)
//                 {
//                     [weakSelf movementsParsing:object];
//                     //主线程刷新
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                         [weakSelf reloadTableView];
//                         [weakSelf.leftView.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                         UIScrollView *myScrollView = (UIScrollView *)[weakSelf.myTableView superview];
//                         myScrollView.contentOffset = CGPointMake(0, 0);
//
//                     });
//                 }];
//            }else{
//
//                __block NSMutableArray *issu = [NSMutableArray array];
//                NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
//                NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                for (NSInteger i =1; i < 31; i++) {
//                    [issu addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
//                }
//                [issu addObject:@"出现总次数"];
//                [issu addObject:@"平均遗漏值"];
//                [issu addObject:@"最大遗漏值"];
//                [issu addObject:@"最大连出值"];
//
//                weakSelf.rightView.issueArr =   weakSelf.issueArr =  weakSelf.leftView.leftDataArray = issu;
//                weakSelf.numberArr = weakSelf.evenValueArr = weakSelf.maxValuesArr= weakSelf.valuesArr = contentArr;
//                weakSelf.rightView.numberArr = weakSelf.rightView.evenValueArr = weakSelf.rightView.maxValuesArr= weakSelf.rightView.valuesArr = _rightContentArr;
//                [weakSelf reloadTableView];
//            }
//        }];

        UILabel *classifyView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, cellHeight*2/3)];
        classifyView.backgroundColor = backgColor;
        classifyView.textAlignment = NSTextAlignmentCenter;
        classifyView.font = [UIFont zkd_systemFontOfSize:14];
        classifyView.textColor = labelTextClor;
        classifyView.text = @"期号";
        [self addSubview:classifyView];

        UILabel *ti = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(classifyView.frame), CGRectGetMinY(classifyView.frame), ScreenW - CGRectGetMaxX(classifyView.frame), cellHeight*2/3/2)];
        ti.backgroundColor = backgColor;
        ti.text = @"号码分布";
        ti.textColor = labelTextClor;
        ti.textAlignment = NSTextAlignmentCenter;
        ti.font = [UIFont zkd_systemFontOfSize:14];
        [self addSubview:ti];


        _leftView = [[BJhappyLeftView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _leftView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_leftView];
        _leftView.sd_layout.leftEqualToView(self).topSpaceToView(classifyView, 0).bottomEqualToView(self).widthIs(CGRectGetWidth(classifyView.frame));

        _myTableView =[[UITableView alloc]initWithFrame:CGRectMake(100, 100, 100, 100) style:UITableViewStylePlain];
        _myTableView.backgroundColor = self.backgroundColor;
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.tableFooterView = [UIView new];
        _myTableView.allowsSelection = NO;
        _myTableView.bounces = NO;
        _myTableView.separatorColor = lineColor;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _myTableView.rowHeight = cellHeight/2;

        _rightView = [[luckRightView alloc]init];
        _rightView.backgroundColor = [UIColor whiteColor];
        _rightView.contentArr = _rightContentArr;
        _rightView.playGroupId = playGroupId;
//
        UIScrollView *myScrollView=[[UIScrollView alloc]init];
        myScrollView.bounces=NO;
        myScrollView.backgroundColor = [UIColor whiteColor];
        myScrollView.contentSize=CGSizeMake(cellHeight/2 * (_contentArr.count+_rightContentArr.count), 0);

        [myScrollView addSubview: _myTableView];
        _myTableView.sd_layout.leftSpaceToView(myScrollView, 0).topSpaceToView(myScrollView, 0).widthIs(cellHeight/2 * _contentArr.count).bottomEqualToView(myScrollView);

        [myScrollView addSubview:_rightView];
        _rightView.sd_layout.leftSpaceToView(_myTableView, 0).topSpaceToView(myScrollView, 0).widthIs(cellHeight/2 * _rightContentArr.count).bottomEqualToView(myScrollView);

        [self addSubview:myScrollView];
        myScrollView.sd_layout.leftSpaceToView(_leftView, 0).topSpaceToView(ti, 0).rightEqualToView(self).bottomSpaceToView(self, 45*kRatio);
        
        
        //  30 50 80期
        nper *n = [[nper alloc]initWithFrame:CGRectMake(0, ScreenH-45*kRatio-kBottomSafeArea-kViewTop, ScreenW, 45*kRatio) digital:self.nperTag];
        [n nperBtnBlock:^(NSInteger btnTag) {
            weakSelf.nperTag = btnTag;
            [n reloadButtonColor:btnTag];
            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
//            if ([weakSelf.yyCache containsObjectForKey:_cacheKey]==YES) {
//                [weakSelf.yyCache objectForKey:_cacheKey withBlock:^(NSString * _Nonnull key, id object)
//                 {
//                     [weakSelf movementsParsing:object];
//                     //主线程刷新
//                     dispatch_async(dispatch_get_main_queue(), ^{
//                         [weakSelf reloadTableView];
//                         [weakSelf.leftView.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//                         UIScrollView *myScrollView = (UIScrollView *)[weakSelf.myTableView superview];
//                         myScrollView.contentOffset = CGPointMake(0, 0);
//
//                     });
//                 }];
//            }else{

                __block NSMutableArray *issu = [NSMutableArray array];
                NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
                NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
                for (NSInteger i =1; i < 31; i++) {
                    [issu addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
                }
                [issu addObject:@"出现总次数"];
                [issu addObject:@"平均遗漏值"];
                [issu addObject:@"最大遗漏值"];
                [issu addObject:@"最大连出值"];

                weakSelf.rightView.issueArr =   weakSelf.issueArr =  weakSelf.leftView.leftDataArray = issu;
                weakSelf.numberArr = weakSelf.evenValueArr = weakSelf.maxValuesArr= weakSelf.valuesArr = contentArr;
                weakSelf.rightView.numberArr = weakSelf.rightView.evenValueArr = weakSelf.rightView.maxValuesArr= weakSelf.rightView.valuesArr = _rightContentArr;
                [weakSelf reloadTableView];
//            }
//
        }];
        [self addSubview:n];


//        if ([_yyCache containsObjectForKey:_cacheKey]==YES) {
//            [_yyCache objectForKey:_cacheKey withBlock:^(NSString * _Nonnull key, id object)
//            {
//                [weakSelf movementsParsing:object];
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf reloadTableView];
//                });
//            }];
//        }

    }
    return self;
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
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  _issueArr.count*cellHeight/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cellHeight/2 *  _contentArr.count, cellHeight*2/3)];
    headView.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < _contentArr.count; i++) {
        NSString *numberStr = [NSString stringWithFormat:@"%d",i];

        SerialLabel *num=[[SerialLabel alloc]initWithFrame:CGRectMake(i * (cellHeight/2), 0, cellHeight/2, cellHeight*2/3/2)];
        num.label.bounds = num.bounds;
        num.label.text = numberStr;

        [headView addSubview:num];
    }
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3/2;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSArray *openCode;
//    if (indexPath.row<_issueArr.count-4) {
//        openCode = _resultsArr[indexPath.row];
//    }else if (indexPath.row==_issueArr.count-4){
//        openCode = _numberArr;
//    }else if (indexPath.row==_issueArr.count-3){
//        openCode = _valuesArr;
//    }else if (indexPath.row==_issueArr.count-2){
//        openCode = _maxValuesArr;
//    }else if (indexPath.row==_issueArr.count-1){
//        openCode = _evenValueArr;
//    }
//
//    return [tableView cellHeightForIndexPath:indexPath model:openCode keyPath:@"openCode" cellClass:[BJhappyTableViewCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.issueArr.count;
//}
//同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = _leftView.leftTableView.contentOffset;

    CGPoint timeOffsetRY = _rightView.myTableView.contentOffset;

    timeOffsetRY.y= timeOffsetY.y = offsetY;

    _rightView.myTableView.contentOffset =  _leftView.leftTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {
        _rightView.myTableView.contentOffset =  _leftView.leftTableView.contentOffset=CGPointZero;
        
    }
}

-(void)setNperTag:(NSInteger)nperTag{
    _nperTag = nperTag;
    _pageSize =  _nperTag == 0 ? @"30": _nperTag == 1 ? @"50":@"80";


    UIButton *btn = n.btnArr[_nperTag];
    [n btnClick:btn];
}

-(void)movementsParsing:(NSDictionary *)json{

    __weak __typeof(self) weakSelf = self;
    [LuckyTwentyEightBaseClass requstWithSuccess:json nper:[_pageSize integerValue] returnValue:^(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr, NSMutableArray *valueResultsArr, NSMutableArray *valueNumberArr, NSMutableArray *valueValuesArr, NSMutableArray *valueMaxValuesArr, NSMutableArray *valueEvenValueArr) {
        weakSelf.issueArr =issueArr;
        weakSelf.resultsArr=resultsArr;
        weakSelf.numberArr = numberArr;
        weakSelf.valuesArr = valuesArr;
        weakSelf.maxValuesArr = maxValuesArr;
        weakSelf.evenValueArr = evenValueArr;
        weakSelf.leftView.leftDataArray = issueArr;
        //
        weakSelf.rightView.issueArr = issueArr;
        weakSelf.rightView.resultsArr = valueResultsArr;

        weakSelf.rightView.numberArr = valueNumberArr;

        weakSelf.rightView.valuesArr = valueValuesArr;

        weakSelf.rightView.maxValuesArr = valueMaxValuesArr;

        weakSelf.rightView.evenValueArr = valueEvenValueArr;
    }];

}
-(void)reloadTableView{
    [_myTableView reloadData];
    [self.leftView.leftTableView reloadData];
    [self.rightView.myTableView reloadData];
}
@end
