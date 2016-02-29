//
//  LeftMenuViewController.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "AppDelegate.h"
#import "ITRAirSideMenu.h"
#import "ViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"
@interface LeftMenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,retain) NSArray *titles;
@end

@implementation LeftMenuViewController

+(instancetype)controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LeftMenuViewController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _titles = @[@"汽车导购", @"改装案例", @"周边商城", @"关于我们"];
    // Do any additional setup after loading the view.
    //获取沙盒主路径
    //NSString *path = NSHomeDirectory();
   // NSLog(@"%@",path);
  
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ITRAirSideMenu *itrsideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    switch (indexPath.row) {
        case 0:
            [itrsideMenu setContentViewController:[[UINavigationController alloc]initWithRootViewController:[ViewController controller]] animated:YES];
            [itrsideMenu hideMenuViewController];
            break;
        case 1:
            [itrsideMenu setContentViewController:[[UINavigationController alloc]initWithRootViewController:[SecondViewController controller]]animated:YES];
            [itrsideMenu hideMenuViewController];
            break;
        case 2:
            [itrsideMenu setContentViewController:[[UINavigationController alloc]initWithRootViewController:[ThirdViewController controller]]animated:YES];
            [itrsideMenu hideMenuViewController];
            break;
        case 3:
            [itrsideMenu setContentViewController:[[UINavigationController alloc]initWithRootViewController:[FouthViewController controller]]animated:YES];
            [itrsideMenu hideMenuViewController];
            break;
        default:
            break;
    }
    
}
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];

    cell.textLabel.text =[_titles objectAtIndex:indexPath.row];

    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
