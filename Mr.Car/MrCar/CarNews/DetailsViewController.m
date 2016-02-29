//
//  DetailsViewController.m
//  MrCar
//
//  Created by xalo on 15/10/10.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "DetailsViewController.h"
#import "ViewController.h"
#import "JsonModel.h"
@interface DetailsViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIView *View1;
@property(nonatomic,strong)UIActivityIndicatorView *indicatorView;//加载页面
@property(nonatomic,retain)UIImage *image1;
@end
@implementation DetailsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _image1 = [[UIImage alloc]init];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor clearColor];
    [self creatWebView];
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.View1 addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicatorView stopAnimating];
    [self.View1 removeFromSuperview];
    //    NSLog(@"DidFinishedLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    //    NSLog(@"error");
}

- (void)creatWebView {
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    NSString *httpUrl = [NSString stringWithString:_newsHttp];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:httpUrl]];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;//缓存策略
    [self.view addSubview:_webView];
    [_webView loadRequest:request];
    
    _View1 = [[UIView alloc] initWithFrame:self.view.bounds];
    _View1.backgroundColor = [UIColor blackColor];
    _View1.alpha = 0.5;
    [self.view addSubview:self.View1];
    
    _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    _indicatorView.center = _View1.center;
    [_indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
}


-(void)leftBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
