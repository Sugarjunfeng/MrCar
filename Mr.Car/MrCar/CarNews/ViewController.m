//
//  ViewController.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ITRAirSideMenu.h"
#import "MenuListViewCell.h"
#import "DetailsViewController.h"
#import "JsonModel.h"
#import "MJRefresh.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chooseSegment;
@property(nonatomic,retain)NSDictionary *dataSource;
@property(nonatomic,retain)NSArray *URlArray;
@property(nonatomic,retain)NSMutableArray *temp;//导航
@property(nonatomic,retain)NSMutableArray *temp1;//评测
@property(nonatomic,retain)NSMutableArray *temp2;//新闻
@property (nonatomic,assign) int index;
@end
static int i = 1;
static int j = 1;
static int k = 1;
@implementation ViewController
-(NSDictionary *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSDictionary dictionary];
    }
    return _dataSource;
}
+(instancetype)controller{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ViewController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

    //注册cell
    [_tableView registerClass:[MenuListViewCell class] forCellReuseIdentifier:@"cell"];
    _temp = [[NSMutableArray alloc] init];
    _temp1 = [[NSMutableArray alloc]init];
    _temp2 = [[NSMutableArray alloc]init];
 
    //chooseSegment添加点击事件
    self.chooseSegment.selectedSegmentIndex = 0;
    [_chooseSegment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    NSString *str = @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=4&ver=6.2";
    [self getdata:str :@""];
    
  
    
    //segmentControl点击存放的网址
    _URlArray = @[@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=4&ver=6.2",@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=3&ver=6.2",@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=2&ver=6.2"];
    [self refresh];
    [self reload];

}
#pragma mark - JSON
-(void)getdata:(NSString *)sender :(NSString *)tag{
    JsonModel *json = [[JsonModel alloc]init];
    [json getRequestMethodWithUrlString:sender parameter:nil];
    json.passValueBlock = ^(NSDictionary *dic){
        _dataSource = dic;
        //NSLog(@"gsgsdgsdg%@",_dataSource);
        if ([tag isEqualToString:@"refresh"]) {
            [_temp removeAllObjects];
            [_temp1 removeAllObjects];
            [_temp2 removeAllObjects];
        }
        for (NSDictionary *dict in _dataSource[@"newsList"]) {
            if (_chooseSegment.selectedSegmentIndex == 0) {
                [_temp addObject:dict];
            }if (_chooseSegment.selectedSegmentIndex == 1) {
                [_temp1 addObject:dict];
            }if (_chooseSegment.selectedSegmentIndex == 2) {
                [_temp2 addObject:dict];
            }

        }
 
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    };
}

#pragma mark - segmentAction
-(void)segmentAction:(UISegmentedControl *)segmentControl{
    _index = (int)_chooseSegment.selectedSegmentIndex;
    switch (self.chooseSegment.selectedSegmentIndex) {
        case 0:
        {
            NSString *urlStr = @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=4&ver=6.2";
            [self getdata:urlStr :@""];
            _index = 0;
        }
            break;
        case 1:
        {
            NSString *urlStr = @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=3&ver=6.2";
            [self getdata:urlStr :@""];
            _index = 1;
        }
            break;
        case 2:
        {
            NSString *urlStr = @"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=0&type=2&ver=6.2";
            [self getdata:urlStr :@""];
            _index = 2;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 下拉刷新
-(void)refresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        i = 1;
        j = 1;
        k = 1;
        [self getdata:_URlArray[(int)_index] :@"refresh"];
        self.tableView.mj_header.center = self.view.center;
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 上拉加载
-(void)reload{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSString *reloadStr = nil;
        if (_chooseSegment.selectedSegmentIndex == 0) {
            //static int i = 0;
            //++i
            reloadStr = [NSString stringWithFormat:@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=%d&type=4&ver=6.2",i*10];
            ++i;
            _index = 0;
        }if (_chooseSegment.selectedSegmentIndex == 1) {
            //static int i = 0;
            //++i;
            reloadStr = [NSString stringWithFormat:@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=%d&type=3&ver=6.2",j*10];
            ++j;
            _index = 1;
        }if (_chooseSegment.selectedSegmentIndex == 2) {
            //static int i = 0;
            //++i;
            reloadStr = [NSString stringWithFormat:@"http://a.xcar.com.cn/interface/6.0/getNewsList.php?limit=10&offset=%d&type=2&ver=6.2",k*10];
            ++k;
            _index = 2;
        }
        [self getdata:reloadStr :@"reload"];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.mj_footer.hidden = YES;
        self.tableView.mj_footer.center = self.view.center;
    }];
}

#pragma mark - pushToLeftMenuController
-(void)presentLeftMenuViewController{
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}

#pragma mark - UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *array = nil;
    if (_chooseSegment.selectedSegmentIndex == 0) {
        array = _temp;
        return array.count;
    }if (_chooseSegment.selectedSegmentIndex == 1) {
        array = _temp1;
        return array.count;
    }if (_chooseSegment.selectedSegmentIndex == 2) {
        array = _temp2;
        return array.count;
    }
    return array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    //判断下标
    if (_chooseSegment.selectedSegmentIndex == 0) {
        [cell passValue:_temp[indexPath.row]];
    }if (_chooseSegment.selectedSegmentIndex == 1) {
        [cell passValue:_temp1[indexPath.row]];
    }if (_chooseSegment.selectedSegmentIndex == 2) {
        [cell passValue:_temp2[indexPath.row]];
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


#pragma mark - cellDone
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    if (_chooseSegment.selectedSegmentIndex == 0) {
        NSString *urlStr = [_temp[indexPath.row]objectForKey:@"newsLink"];
        detailsVC.newsHttp = urlStr;
    }
    if (_chooseSegment.selectedSegmentIndex == 1) {
        NSString *urlStr = [_temp1[indexPath.row]objectForKey:@"newsLink"];
        detailsVC.newsHttp = urlStr;
    }
    if (_chooseSegment.selectedSegmentIndex == 2) {
        NSString *urlStr = [_temp2[indexPath.row]objectForKey:@"newsLink"];
        detailsVC.newsHttp = urlStr;
    }
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
