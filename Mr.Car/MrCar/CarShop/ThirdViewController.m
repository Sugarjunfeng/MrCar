//
//  ThirdViewController.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "ThirdViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"
#import "JsonModel.h"
#import "ThirdViewCell.h"
#import "MJRefresh.h"
#import "ThirdDetailsViewController.h"
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSDictionary *dataSource;
@property(nonatomic,retain)NSArray *temp;
@end

@implementation ThirdViewController
-(NSDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSDictionary dictionary];
    }
    return _dataSource;
}

+(instancetype)controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ThirdViewController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuController)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    //注册cell
    [_tableView registerClass:[ThirdViewCell class] forCellReuseIdentifier:@"cell"];
    
        NSString *url = @"http://api.smzdm.com/v1/youhui/articles/?category=147&f=wp&s=wnXQwdyEkKcFseaKLgx626%2F7l1U%3D&limit=50&v=2.5";
    [self getDara:url];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];

    
}

#pragma mark - JsonUrl
-(void)getDara:(NSString *)sender{
        JsonModel *json = [[JsonModel alloc]init];
        [json getRequestMethodWithUrlString:sender parameter:nil];
        json.passValueBlock = ^(NSDictionary *dic){
            _dataSource = dic;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        };

}

-(void)refresh{
    NSString *url =@"http://api.smzdm.com/v1/youhui/articles/?category=147&f=wp&s=wnXQwdyEkKcFseaKLgx626%2F7l1U%3D&limit=50&v=2.5";
    [self getDara:url];
    [self.tableView.mj_header endRefreshing];
}


//跳转菜单界面
#pragma mark - pushToLeftMenuController
-(void)presentLeftMenuController{
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *dict = _dataSource[@"data"];
    _temp = (NSArray *)dict[@"rows"];
    return _temp.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell passValue:_temp[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


#pragma mark - cellDone
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ThirdDetailsViewController *tdVC = [[ThirdDetailsViewController alloc]init];
    tdVC.goodsHttp = _dataSource[@"data"][@"rows"][indexPath.row][@"article_link"];
    [self.navigationController pushViewController:tdVC animated:YES];
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
