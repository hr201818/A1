//
//  BJhappyView.m
//  Ticket
//
//  Created by pro on 2017/9/1.
//  Copyright © 2017年 xigu. All rights reserved.
//

#import "BJhappyView.h"
#import "Header.h"
#import "lotteryNper.h"
#import "BJhappyLeftView.h"
#import "DSDrawingViewController.h"
#import "SerialLabel.h"
#import "nper.h"
#import "BeiJingHappyTableViewCell.h"
@interface BJhappyView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_contentArr;
    lotteryNper *n;
    NSString *cacheKey;
    NSMutableArray *_numberArray;
    NSMutableArray *_openCodeArray;
}
@property (nonatomic,copy)NSString *pageSize;

//@property (nonatomic,strong) YYCache *yyCache;//缓存
@property (nonatomic, strong) BJhappyLeftView *leftView;

@end
@implementation BJhappyView

-(id)initWithFrame:(CGRect)frame playGroupId:(NSString *)playGroupId contentArr:(NSMutableArray *)contentArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        self.nperTag = 0;
        cacheKey=[NSString stringWithFormat:@"playGroupId%@",playGroupId];
        _contentArr = [NSMutableArray arrayWithArray:contentArr];
        _numberArray = [[NSMutableArray alloc]initWithCapacity:0];
        _openCodeArray= [[NSMutableArray alloc]initWithCapacity:0];
        __weak __typeof(self) weakSelf = self;
//        _yyCache=[YYCache cacheWithName:@"zoushiCache"];

//        n = [[lotteryNper alloc]initWithFrame:CGRectMake(0,5, ScreenW, 40)];
//        n.backgroundColor =[UIColor whiteColor];
//        [self addSubview:n];
//        [n lotterNperBtnBlock:^(NSInteger btnTag) {
//
//            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
//            if ([tool arrIsNull:_numberArray]==YES) {
//                 weakSelf.leftView.leftDataArray = [NSMutableArray arrayWithArray:[_numberArray subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
//            }
//                 //主线程刷新
//                 dispatch_async(dispatch_get_main_queue(), ^{
//                     [weakSelf reloadTableView];
//                 });
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
        ti.font = [UIFont zkd_systemFontOfSize:13];

        [self addSubview:ti];


        _leftView = [[BJhappyLeftView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
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
        //        _myTableView.rowHeight = cellHeight/2;

        UIScrollView *myScrollView=[[UIScrollView alloc]init];
        myScrollView.bounces=NO;
        myScrollView.contentSize=CGSizeMake(cellHeight/2 * _contentArr.count, 0);

        [myScrollView addSubview: _myTableView];
        _myTableView.sd_layout.leftSpaceToView(myScrollView, 0).topSpaceToView(myScrollView, 0).widthIs(cellHeight/2 * _contentArr.count).bottomSpaceToView(myScrollView, 0);

        [self addSubview:myScrollView];

        myScrollView.sd_layout.leftSpaceToView(_leftView, 0).topSpaceToView(ti, 0).rightEqualToView(self).bottomSpaceToView(self, 45*kRatio);
        
        //  30 50 80期
        nper *n = [[nper alloc]initWithFrame:CGRectMake(0, self.height - 45*kRatio - Tabbar_HEIGHT, ScreenW, 45*kRatio) digital:self.nperTag];
        [n nperBtnBlock:^(NSInteger btnTag) {
            weakSelf.nperTag = btnTag;
            [n reloadButtonColor:btnTag];
            weakSelf.pageSize =  btnTag == 0 ? @"30": btnTag == 1 ? @"50":@"80";
            if ([tool arrIsNull:_numberArray]==YES) {
                 weakSelf.leftView.leftDataArray = [NSMutableArray arrayWithArray:[_numberArray subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
            }
             //主线程刷新
             dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf reloadTableView];
             });
            
        }];
        [self addSubview:n];


//        if ([_yyCache containsObjectForKey:cacheKey]==YES) {
//            [_yyCache objectForKey:cacheKey withBlock:^(NSString * _Nonnull key, id object)
//            {
//
//                [weakSelf movementsParsing:object];
//
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf reloadTableView];
//                });
//            }];
//        }else{
            __block NSMutableArray *issu = [NSMutableArray array];
            NSString *dat = [[[tool date] componentsSeparatedByString:@" "] firstObject];
            NSString *time = [dat stringByReplacingOccurrencesOfString:@"-" withString:@""];
            for (NSInteger i =1; i < 31; i++) {
                [issu addObject:[NSString stringWithFormat:@"%@%03ld",time,i]];
            }
            self.leftView.leftDataArray = issu;
//        }


    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"cell";
    BeiJingHappyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell ==nil) {
        cell = [[BeiJingHappyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    if (indexPath.row %2 == 0) {
        cell.backgroundColor= backgColor;
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }

    if ([tool arrIsNull:_openCodeArray]==YES) {
        NSString *opencode = _openCodeArray[indexPath.row];
        cell.openCodeArray = [opencode componentsSeparatedByString:@","];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return cellHeight/2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_pageSize integerValue];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cellHeight/2 * _contentArr.count, cellHeight*2/3/2)];
    headView.backgroundColor = [UIColor whiteColor];

    for (int i = 0; i < _contentArr.count; i++) {

        NSString *numberStr = [NSString stringWithFormat:@"%@",_contentArr[i]];

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

////同步左侧右侧
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetY = _myTableView.contentOffset.y;

    CGPoint timeOffsetY = _leftView.leftTableView.contentOffset;

    timeOffsetY.y = offsetY;

    _leftView.leftTableView.contentOffset = timeOffsetY;

    if(offsetY == 0) {
        _leftView.leftTableView.contentOffset=CGPointZero;
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

    [_numberArray removeAllObjects];
    [_openCodeArray removeAllObjects];

    NSArray *listArr = json[@"sscHistoryList"];

    for (NSDictionary *dict in listArr) {
        [_numberArray addObject:[NSString stringWithFormat:@"%@",dict[@"number"]]];
        [_openCodeArray addObject:[NSString stringWithFormat:@"%@",dict[@"openCode"]]];
    }
    
    self.leftView.leftDataArray = [NSMutableArray arrayWithArray:[_numberArray subarrayWithRange:NSMakeRange(0, [_pageSize integerValue])]];
}
-(void)reloadTableView{
    [self.myTableView reloadData];
    [self.leftView.leftTableView reloadData];
    UIScrollView *myScrollView = (UIScrollView *)[self.myTableView superview];
    myScrollView.contentOffset = CGPointMake(0, 0);
    [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
