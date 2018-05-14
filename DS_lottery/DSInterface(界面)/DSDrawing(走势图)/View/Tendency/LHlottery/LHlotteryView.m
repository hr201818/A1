//
//  LHlotteryView.m
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "LHlotteryView.h"
#import "Header.h"
#import "lhcBaseClass.h"
#import "BJhappyLeftView.h"
#import "lhcBaseClass.h"
#import "lhcTotalView.h"
#import "lhcTemaView.h"
#import "lotteryNper.h"
#import "DSDrawingViewController.h"
#import "lhcNumberLabelView.h"
#import "lhcListView.h"
#import "LiuHeTableViewCell.h"
#import "nper.h"
@interface LHlotteryView ()<UITableViewDelegate,UITableViewDataSource>
{
    lotteryNper *n;
    NSArray *_headerArr;
    NSArray *_totalHeaderArr;
    NSArray *_temaHeaderArr;
}
@property (nonatomic,copy)NSString *pageSize;
@property (nonatomic,copy) NSString *cacheKey;//缓存key
//@property (nonatomic,strong) YYCache *yyCache;//缓存

@property (nonatomic, strong) BJhappyLeftView *leftView;
@property (nonatomic, strong) lhcTotalView *totalView;
@property (nonatomic, strong) lhcTemaView *temaView;
@property (nonatomic,strong)NSMutableArray *issueArr;//期号
@property (nonatomic,strong)NSMutableArray *resultsArr;//开奖结果
@property (nonatomic,strong)NSMutableArray *totalArr;//总和
@property (nonatomic,strong)NSMutableArray *temaArr;//特码

@end
@implementation LHlotteryView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId headerArr:(NSArray *)headerArr totalHeaderArr:(NSArray *)totalHeaderArr temaHeaderArr:(NSArray *)temaHeaderArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.cacheKey=[NSString stringWithFormat:@"playGroupId%@",playGroupId];
        _headerArr = headerArr;
        _totalHeaderArr = totalHeaderArr;
        _temaHeaderArr = temaHeaderArr;
        self.nperTag = 0;
        __weak __typeof(self) weakSelf = self;
//        _yyCache=[YYCache cacheWithName:@"zoushiCache"];


//        n = [[lotteryNper alloc]initWithFrame:CGRectMake(0,5, ScreenW, 40)];
//        n.backgroundColor =[UIColor whiteColor];
//        [self addSubview:n];
//        [n lotterNperBtnBlock:^(NSInteger btnTag) {
//
//            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
//            NSInteger qishi = [_pageSize integerValue];
//            if (qishi>=weakSelf.issueArr.count) {
//                qishi = weakSelf.issueArr.count;
//            }
//            if ([tool  arrIsNull:weakSelf.totalArr]==YES) {
//                weakSelf.temaView.issueArr=weakSelf.totalView.issueArr=weakSelf.leftView.leftDataArray =[NSMutableArray arrayWithArray:[weakSelf.issueArr subarrayWithRange:NSMakeRange(0, qishi)]];
//                weakSelf.totalView.totalArr = [NSMutableArray arrayWithArray:[weakSelf.totalArr subarrayWithRange:NSMakeRange(0, qishi)]];
//                weakSelf.temaView.temaArr = [NSMutableArray arrayWithArray:[weakSelf.temaArr subarrayWithRange:NSMakeRange(0, qishi)]];
//
//                [weakSelf reloadTableView];
//            }
//
//        }];


        UILabel *classifyView = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(n.frame)+5, 80, cellHeight*2/3)];
        classifyView.backgroundColor = backgColor;
        classifyView.textAlignment = NSTextAlignmentCenter;
        classifyView.font = [UIFont zkd_systemFontOfSize:14];
        classifyView.textColor = labelTextClor;
        classifyView.text = @"期号";
        [self addSubview:classifyView];

        _leftView = [[BJhappyLeftView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _leftView.isLH = YES;
        _leftView.backgroundColor = [UIColor orangeColor];
        [self addSubview:_leftView];
        _leftView.sd_layout.leftEqualToView(self).topSpaceToView(classifyView, 0).bottomEqualToView(self).widthIs(CGRectGetWidth(classifyView.frame));

        _myTableView =[[UITableView alloc]initWithFrame:self.frame style:UITableViewStylePlain];
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

        _totalView = [[lhcTotalView alloc]init];
        _totalView.totalHeaderArr = [NSMutableArray arrayWithArray:totalHeaderArr];

        _temaView = [[lhcTemaView alloc]init];
        _temaView.temaHeaderArr = [NSMutableArray arrayWithArray:temaHeaderArr];


        UIScrollView *myScrollView=[[UIScrollView alloc]init];
        myScrollView.bounces=NO;
        myScrollView.contentSize=CGSizeMake((lhWidth*headerArr.count)+(lhWidthTow * totalHeaderArr.count) + (lhWidthThree *temaHeaderArr.count), 0);

        [myScrollView addSubview: _myTableView];
        _myTableView.sd_layout.leftSpaceToView(myScrollView, 0).topSpaceToView(myScrollView, 0).widthIs(lhWidth * headerArr.count).bottomSpaceToView(myScrollView, 0);

        [myScrollView addSubview:_totalView];
        _totalView.sd_layout.leftSpaceToView(_myTableView, 0).topSpaceToView(myScrollView, 0).widthIs(lhWidthTow * totalHeaderArr.count).bottomEqualToView(myScrollView);
//
        [myScrollView addSubview:_temaView];
        _temaView.sd_layout.leftSpaceToView(_totalView, 0).topSpaceToView(myScrollView, 0).widthIs(lhWidthThree * temaHeaderArr.count).bottomEqualToView(myScrollView);

        [self addSubview:myScrollView];
        myScrollView.sd_layout.leftSpaceToView(_leftView, 0).topEqualToView(classifyView).rightEqualToView(self).bottomSpaceToView(self, 45*kRatio);
        
        
        //  30 50 80期
        nper *n = [[nper alloc]initWithFrame:CGRectMake(0, ScreenH-45*kRatio-kBottomSafeArea-kViewTop, ScreenW, 45*kRatio) digital:self.nperTag];
        [n nperBtnBlock:^(NSInteger btnTag) {
            weakSelf.nperTag = btnTag;
            [n reloadButtonColor:btnTag];
            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
            NSInteger qishi = [_pageSize integerValue];
            if (qishi>=weakSelf.issueArr.count) {
                qishi = weakSelf.issueArr.count;
            }
            if ([tool  arrIsNull:weakSelf.totalArr]==YES) {
                weakSelf.temaView.issueArr=weakSelf.totalView.issueArr=weakSelf.leftView.leftDataArray =[NSMutableArray arrayWithArray:[weakSelf.issueArr subarrayWithRange:NSMakeRange(0, qishi)]];
                weakSelf.totalView.totalArr = [NSMutableArray arrayWithArray:[weakSelf.totalArr subarrayWithRange:NSMakeRange(0, qishi)]];
                weakSelf.temaView.temaArr = [NSMutableArray arrayWithArray:[weakSelf.temaArr subarrayWithRange:NSMakeRange(0, qishi)]];

                [weakSelf reloadTableView];
            }
            
        }];
        [self addSubview:n];
        
        
        ////
        
//        if ([_yyCache containsObjectForKey:self.cacheKey]==YES) {
//            [_yyCache objectForKey:self.cacheKey withBlock:^(NSString * _Nonnull key, id object) {
//
//                [weakSelf movementsParsing:object];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf reloadTableView];
//                });
//            }];
//        }else{

            __block NSMutableArray *issu = [NSMutableArray array];
             __block NSMutableArray *re = [NSMutableArray array];
             __block NSMutableArray *ad = [NSMutableArray array];
             __block NSMutableArray *te = [NSMutableArray array];

            NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
            NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
            time = [time substringWithRange:NSMakeRange(2, 2)];
            for (NSInteger i =1; i < 31; i++) {
                [issu addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
                __block NSMutableArray *re1 = [NSMutableArray array];
                for (NSInteger i =0; i < 7; i++) {
                    [re1 addObject:[NSString stringWithFormat:@"%02d",arc4random() % 50]];
                }
                [re addObject:re1];
                [ad addObject:@[@"100",@"总和单双",@"总和大小",@"红蓝波"]];
                [te addObject:weakSelf.temaView.temaHeaderArr];
                
            }
            weakSelf.issueArr =weakSelf.temaView.issueArr=weakSelf.totalView.issueArr=weakSelf.leftView.leftDataArray = issu;

            weakSelf.resultsArr = re;
//
            weakSelf.totalView.totalArr =ad;
//
            weakSelf.temaView.temaArr = te;
            [weakSelf reloadTableView];
            
//        }



        
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    LiuHeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[LiuHeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if (indexPath.row %2 == 0) {
        cell.backgroundColor= backgColor;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    if ([tool arrIsNull:_resultsArr]==YES) {
         cell.openCodeArray = _resultsArr[indexPath.row];
    }

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _temaView.issueArr.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, lhWidth *_headerArr.count, cellHeight*2/3)];
    headView.backgroundColor = backgColor;

    for (int i = 0; i < _headerArr.count; i++) {
        UILabel *hea = [[UILabel alloc]initWithFrame:CGRectMake(i * (lhWidth), 0, lhWidth, cellHeight*2/3)];
        hea.text =_headerArr[i];
        hea.font = [UIFont zkd_systemFontOfSize:11];
        hea.textAlignment = NSTextAlignmentCenter;
        hea.textColor = labelTextClor;
        [headView addSubview:hea];


        UIBezierPath *linePath = [UIBezierPath bezierPath];
        //  起点
        [linePath moveToPoint:(CGPoint){(i+1) * (lhWidth),0}];
        // 其他点
        [linePath addLineToPoint:(CGPoint){(i+1) * (lhWidth),cellHeight*2/3}];
        //  设置路径画布
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.lineWidth = 1;
        lineLayer.strokeColor = lineColor.CGColor; //   边线颜色
        lineLayer.path = linePath.CGPath;
        lineLayer.fillColor  = nil;   //  默认是black
        //  添加到图层上
        [headView.layer addSublayer:lineLayer];
    }

    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellHeight*2/3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = _leftView.leftTableView.contentOffset;

    timeOffsetY.y = offsetY;

    _temaView.temaTableView.contentOffset = _totalView.myTableView.contentOffset= _leftView.leftTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {
        _temaView.temaTableView.contentOffset = _totalView.myTableView.contentOffset= _leftView.leftTableView.contentOffset=CGPointZero;
    }
}




-(void)setNperTag:(NSInteger)nperTag{
    _nperTag = nperTag;
    _pageSize =  _nperTag == 0 ? @"30": _nperTag == 1 ? @"50":@"80";

    UIButton *btn = n.btnArr[_nperTag];
    for (UIButton *button in n.btnArr) {
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.backgroundColor =[UIColor whiteColor];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5.0f;
        button.layer.borderColor = [[UIColor grayColor] CGColor];
    }

    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor =navColor;
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5.0f;
    btn.layer.borderColor = [navColor CGColor];
}
-(void)movementsParsing:(NSDictionary *)json{
    __weak __typeof(self) weakSelf = self;

    [lhcBaseClass requstWithSuccess:json nper:80 returnValue:^(NSMutableArray *issueArr, NSMutableArray *resultsArr, NSMutableArray *totalArr, NSMutableArray *temaArr) {
        weakSelf.issueArr = issueArr;
        weakSelf.resultsArr = resultsArr;
        weakSelf.totalArr = totalArr;
        weakSelf.temaArr = temaArr;
        
        if (issueArr.count<[_pageSize integerValue]) {
            _pageSize = [NSString stringWithFormat:@"%ld",issueArr.count];
        }
        weakSelf.temaView.issueArr = weakSelf.totalView.issueArr=weakSelf.leftView.leftDataArray = [NSMutableArray arrayWithArray:[issueArr subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
        
        weakSelf.totalView.totalArr = [NSMutableArray arrayWithArray:[totalArr subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
        weakSelf.temaView.temaArr = [NSMutableArray arrayWithArray:[temaArr subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
    }];
}
-(void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{

        [self.myTableView reloadData];
        [self.leftView.leftTableView reloadData];
        [self.totalView.myTableView reloadData];
        [self.temaView.temaTableView reloadData];
//        [_myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//        UIScrollView *myScrollView = (UIScrollView *)[_myTableView superview];
//        myScrollView.contentOffset = CGPointMake(0, 0);
//         [MBProgressHUD hideHUDForView:self animated:YES];
    });

//    [_myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
//    UIScrollView *myScrollView = (UIScrollView *)[_myTableView superview];
//    myScrollView.contentOffset = CGPointMake(0, 0);
}

@end
