//
//  FouthViewController.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "FouthViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//获取当前屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//获取当前屏幕高度
#define ImageHeight 300


@interface FouthViewController ()

@property(nonatomic,retain)UILabel *label;
@property(nonatomic,retain)UILabel *explainLabel;
@property(nonatomic,retain)UIImageView *fouthImage;

@end

@implementation FouthViewController

+(instancetype)controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([FouthViewController class])];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuController)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor whiteColor];
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(netChange) name:kReachabilityChangedNotification object:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"清除缓存" style:UIBarButtonItemStylePlain target:self action:@selector(removeCache)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    
    
    [self initSubView];
    
}
-(void)initSubView{
    _fouthImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, ImageHeight)];
    _fouthImage.image = [UIImage imageNamed:@"009.png"];
    [self.view addSubview:_fouthImage];
    _label = [[UILabel alloc]initWithFrame:CGRectMake(0, ImageHeight, SCREEN_WIDTH, 60)];
    _label.text = @"应用说明";
    _label.font = [UIFont fontWithName:nil size:20];
    _label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_label];
    _explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ImageHeight + 20, SCREEN_WIDTH, SCREEN_HEIGHT - ImageHeight - 60)];
    _explainLabel.numberOfLines = 0;
    //_explainLabel.backgroundColor = [UIColor blackColor];
    _explainLabel.text = @"本应用仅供开发和交流学习使用，严禁用于商业用途.\n开发者:小唐羽锋\n邮箱:455525201@qq.com\n建议您定期清除缓存,以避免程序卡顿";
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_explainLabel];

}
-(void)removeCache{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSArray *files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
        //NSLog(@"%ld",[files count]);
        for (NSString *p in files) {
            NSError *error;
            NSString *path = [cachePath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager]fileExistsAtPath:path]) {
                [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            }
        }
        [self performSelectorOnMainThread:@selector(clearCaches) withObject:self waitUntilDone:YES];
    });
}
-(void)clearCaches{
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"清除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
    NSLog(@"清理成功");
}

#pragma mark - pushToLeftMenuController
-(void)presentLeftMenuController{
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
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
