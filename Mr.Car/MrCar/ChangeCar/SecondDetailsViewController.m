//
//  SecondDetailsViewController.m
//  MrCar
//
//  Created by xalo on 15/10/12.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "SecondDetailsViewController.h"
#import "CollectionViewCell.h"
#import "LineLayout.h"
#import "UIImageView+WebCache.h"
@interface SecondDetailsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end

@implementation SecondDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];

    
    LineLayout *layout = [[LineLayout alloc]init];
    UICollectionView *myCollectionView =[[UICollectionView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    myCollectionView.backgroundColor = [UIColor clearColor];
    myCollectionView.delegate = self;
    myCollectionView.dataSource = self;
    
    [myCollectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    [self.view addSubview:myCollectionView];

}
-(void)pop{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - myCollectionView DataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return _dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.textView.text = _dataArray[indexPath.row][@"description"];
    NSURL *imageUrl = _dataArray[indexPath.row][@"p_link"];
    UIImage *placeImage = [UIImage imageNamed:@"008.png"];
    [cell.carImage sd_setImageWithURL:imageUrl placeholderImage:placeImage];
    return cell;
}

#pragma mark - cellDone
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
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
