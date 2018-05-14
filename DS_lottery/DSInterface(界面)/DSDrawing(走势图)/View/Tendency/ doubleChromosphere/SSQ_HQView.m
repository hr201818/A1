//
//  SSQ_HQView.m
//  Ticket
//
//  Created by pro on 2017/11/6.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "SSQ_HQView.h"
#import "Header.h"
#import "SSQ_LQView.h"
#import "BJhappyLeftView.h"
#import "lotteryNper.h"
#import "SSQBaseClass.h"
#import "SSQHQTableViewCell.h"
#import "TotUpTableViewCell.h"
#import "nper.h"
@interface SSQ_HQView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_contentArr;
    NSMutableArray *_rightContentArr;
    lotteryNper *n;

}
@property (nonatomic,copy)NSString *pageSize;
@property (nonatomic,copy)NSString *cacheKey;
@property (nonatomic, strong) SSQ_LQView *rightView;
@property (nonatomic, strong) BJhappyLeftView *leftView;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *numberArr;//总次数
@property (nonatomic,strong)NSMutableArray *valuesArr;//平均遗漏值
@property (nonatomic,strong)NSMutableArray *maxValuesArr;//最大遗漏值
@property (nonatomic,strong)NSMutableArray *evenValueArr;//连出值
@end
@implementation SSQ_HQView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr rightContentArr:(NSMutableArray *)rightContentArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cacheKey=[NSString stringWithFormat:@"playGroupId%@",playGroupId];
        _contentArr = [NSMutableArray arrayWithArray:contentArr];
        _rightContentArr = [NSMutableArray arrayWithArray:rightContentArr];
        self.nperTag = 0;
        __weak __typeof(self) weakSelf = self;

//        n = [[lotteryNper alloc]initWithFrame:CGRectMake(0,5, ScreenW, 40)];
//        n.backgroundColor =[UIColor whiteColor];
//        [self addSubview:n];
//        [n lotterNperBtnBlock:^(NSInteger btnTag) {
//             weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
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
//
//        }];
        
        UILabel *classifyView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(n.frame)+5, 100, cellHeight*2/3)];
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

        _rightView = [[SSQ_LQView alloc]init];
        _rightView.backgroundColor = [UIColor whiteColor];
        _rightView.contentArr = _rightContentArr;
        _rightView.playGroupId = playGroupId;

        UIScrollView *myScrollView=[[UIScrollView alloc]init];
        myScrollView.bounces=NO;
        myScrollView.backgroundColor = [UIColor yellowColor];
        myScrollView.contentSize=CGSizeMake(cellHeight/2 * (_contentArr.count+_rightContentArr.count), 0);

        [myScrollView addSubview: _myTableView];
        _myTableView.sd_layout.leftSpaceToView(myScrollView, 0).topSpaceToView(myScrollView, 0).widthIs(cellHeight/2 * _contentArr.count).bottomSpaceToView(myScrollView, 0);

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
            
        }];
        [self addSubview:n];

        
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
                cell.openCodeArray = _resultsArr[indexPath.row];
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
                [cell setopenCodeArray:_numberArr index:0];
//                cell.openCodeArray = _numberArr;
            }
        }else if (indexPath.row==_issueArr.count-3){
            if ([tool arrIsNull:_valuesArr]==YES) {
                [cell setopenCodeArray:_valuesArr index:1];
//                cell.openCodeArray = _valuesArr;
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

    UIView *view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0,_contentArr.count * (cellHeight/2), cellHeight*2/3/2)];
    view.backgroundColor = [UIColor whiteColor];

    UILabel *ti = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,_contentArr.count * (cellHeight/2), cellHeight*2/3/2)];
    ti.backgroundColor = [UIColor whiteColor];
    ti.text = @"红球";
    ti.textAlignment = NSTextAlignmentCenter;
    ti.font = [UIFont zkd_systemFontOfSize:13];
    ti.textColor = labelTextClor;
    [view addSubview:ti];
    //   创建一个路径对象
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    //  起点
    [linePath moveToPoint:(CGPoint){CGRectGetMaxX(ti.frame),0}];
    // 其他点
    [linePath addLineToPoint:(CGPoint){CGRectGetMaxX(ti.frame),CGRectGetHeight(ti.frame)}];
    //  设置路径画布
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 1.0;
    lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor  = nil;   //  默认是black
    //  添加到图层上
    [view.layer addSublayer:lineLayer];

    return view;
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
-(void)setNperTag:(NSInteger)nperTag{
    _nperTag = nperTag;
    _pageSize =  _nperTag == 0 ? @"30": _nperTag == 1 ? @"50":@"80";


    UIButton *btn = n.btnArr[_nperTag];
    [n btnClick:btn];
}
-(void)movementsParsing:(NSDictionary *)json{

    __weak __typeof(self) weakSelf = self;

    [SSQBaseClass requstWithSuccess:json nper:[_pageSize integerValue] returnValue:^(NSMutableArray *issueArr,NSMutableArray *resultsArr,NSMutableArray *numberArr,NSMutableArray *valuesArr,NSMutableArray *maxValuesArr,NSMutableArray *evenValueArr, NSMutableArray *valueResultsArr, NSMutableArray *valueNumberArr, NSMutableArray *valueValuesArr, NSMutableArray *valueMaxValuesArr, NSMutableArray *valueEvenValueArr) {

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
@end
