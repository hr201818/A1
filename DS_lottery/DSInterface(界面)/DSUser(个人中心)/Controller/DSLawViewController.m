//
//  DSLawViewController.m
//  DS_lottery
//
//  Created by pro on 2018/4/25.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSLawViewController.h"

@interface DSLawViewController ()

@end

@implementation DSLawViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"法律声明";

    [self navLeftItem:[DSFuntionTool leftNavBackTarget:self Item:@selector(leftBackAction)]];

    UIScrollView * scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Navgationbar_HEIGHT, self.view.width, PhoneScreen_HEIGHT - Navgationbar_HEIGHT - Tabbarbottom_HEIGHT)];
    [self.view addSubview:scrollView];

    UILabel * content = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.width - 25, 1000)];
    content.text = @" （快乐彩票）是本司（江西艾菲姆科技有限公司）开发的一款彩票软件app,（快乐彩票）仅代为用户购买彩票、保管彩票、领取彩票、派发奖金，而非从事互联网彩票销售的终端，彩种规则、中奖标准的确定、奖金的派发均有彩票发行机构公布的官方规则为准，用户在（快乐彩票）上投注即视为授予（快乐彩票）代理购买彩票、保管彩票、领取奖金和派发奖金的一切权利。\n （江西艾菲姆科技有限公司）（以下称为乙方）同“体育彩票管理发行中心”（甲方）签订合作展开体育彩票销售业务，双方本着平等互利的原则，根据自身优势展开彩票推广业务合作，“体育彩票管理发行中心”是体育彩票管理中心指定的彩票产品渠道合作机构，并负责出品、兑奖等彩票相关事宜，我司负责网络代理购买彩票、保管彩票、领取彩票、派发奖金方便彩民购彩\n甲方权利和义务\n1.甲方授权乙方对全国范围内体育彩票，除现有投注站意外的其他销售渠道相关法律法规进行推广、销售\n2.甲方负责向乙方提供销售所需电脑体育彩票终端及其附属设备\n3.业务合作期间、因甲方主管部分或相关省市法律法规政策调整、甲方有权暂停或单方面终止\n4.甲方严格遵守乙方购买方案的内容，准备、及时、完成彩票购买方案的出票打印、核对工作、并将其出票结果实时反馈给乙方。\n乙方权利和义务\n1.乙方具有从事本合同业务的资源和能力，且网站上提供的彩票信息不违反相关政策\n2.乙方负责网站的运营和管理，并必须对其网站所发生的彩票购买方式、数据内容可靠性、正确性和安全性负责\n本司负责线上销售、推广、代购等事宜，体育彩票管理中心负责对其实时销售的彩票进行初评、开奖等相关事宜";
    content.textColor = COLORFont83;
    content.numberOfLines = 0;
    content.font = [UIFont systemFontOfSize:15];
    [scrollView addSubview:content];
    [content sizeToFit];
    scrollView.contentSize = CGSizeMake(0, content.height + 20);
}


#pragma mark - 点击事件
-(void)leftBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
