//
//  SecondViewController.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "SecondViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"
#import "JsonModel.h"
#import "MJRefresh.h"
#import "SecondListViewCell.h"//自定义cell
#import "SecondDetailsViewController.h"
//#import "Btn_TableView.h"//rightButton下拉列表
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSDictionary *dataSource;
@property(nonatomic,retain)NSMutableArray *array;
@end

static int i =2;

@implementation SecondViewController

-(NSDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSDictionary dictionary];
    }
    return _dataSource;
}

+(instancetype)controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([SecondViewController class])];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _array = [[NSMutableArray alloc]init];
    //初始页面
    NSString *url = @"http://app.api.niuche.com/modi/cases?page=1&count=20&city=%E5%85%A8%E5%9B%BD";
    [self getData:url :@""];
    
    
    //tableViewCell注册
    [_tableView registerClass:[SecondListViewCell class] forCellReuseIdentifier:@"cell"];
  
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    [self reload];
    
}

#pragma mark - JsonData
-(void)getData:(NSString *)sender :(NSString *)tag{
    JsonModel *json = [[JsonModel alloc]init];
    [json getRequestMethodWithUrlString:sender parameter:nil];
    json.passValueBlock = ^(NSDictionary *dic){
        _dataSource = dic;
        if ([tag isEqualToString:@"refresh"]) {
            [_array removeAllObjects];
        }
        for (NSDictionary *dict in _dataSource[@"cases"]) {
            [_array addObject:dict];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    };

}

#pragma mark - refresh
-(void)refresh{
    NSString *str = @"http://app.api.niuche.com/modi/cases?page=1&count=20&city=%E5%85%A8%E5%9B%BD";
    i = 2;
    [self getData:str :@"refresh"];
    [self.tableView.mj_header endRefreshing];
}

-(void)reload{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *str = @"%E5%85%A8%E5%9B%BD";
        //static int i = 2;
        //i++;
        NSString *url = [NSString stringWithFormat:@"http://app.api.niuche.com/modi/cases?page=%d&count=20&city=%@",i,str];
        ++i;
        [self getData:url :@"reload"];
            [self.tableView.mj_footer endRefreshing];

    }];

    
}

#pragma mark - pushToLeftMenuController
-(void)presentLeftMenuViewController{
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}



#pragma mark - TableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell passValue:_array[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
#pragma mark - cellDone
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondDetailsViewController *secondVC = [[SecondDetailsViewController alloc]init];
    NSMutableArray *array = _array[indexPath.row][@"pictures"];
    secondVC.dataArray = array;
    [self.navigationController pushViewController:secondVC animated:YES];
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
