//
//  DSInfoWebTableViewCell.m
//  DS_lottery
//
//  Created by pro on 2018/4/24.
//  Copyright © 2018年 海南达生实业有限公司. All rights reserved.
//

#import "DSInfoWebTableViewCell.h"

@interface DSInfoWebTableViewCell ()<UIWebViewDelegate>
@property (strong, nonatomic) UIWebView    * webView;
@end

@implementation DSInfoWebTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layoutView];
    }
    return self;
}

-(void)layoutView{
    self.contentView.backgroundColor = backColor;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, PhoneScreen_WIDTH, 1)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.scrollView.scrollEnabled = NO;
    [self.contentView addSubview:self.webView];
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];

}
-(void)setWebContent:(NSString *)webContent{
    if(!_webContent.length){
        _webContent = webContent;
        [self.webView loadHTMLString:webContent baseURL:nil];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentSize"]){
        CGSize fa = [self.webView sizeThatFits:CGSizeZero];
        self.webView.frame = CGRectMake(0, 0, fa.width, fa.height);
        if (self.webBlock) {
            self.webBlock(fa.height+ 10);
        }
    }
}
- (void)dealloc{
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    NSLog(@"webView dellock:%@",[self class]);
}
@end
