                 //
//  MenuListViewCell.m
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "MenuListViewCell.h"
#import "UIImageView+WebCache.h"
#import "JsonModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//获取当前屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//获取当前屏幕高度
#define URLImage_WIDTH 100//加载图片的宽度
#define URLImage_HEIGHT 80//加载图片的高度

@implementation MenuListViewCell
{
    UIImageView *_backImage;
    UILabel *_titleLabel;
    UILabel *_modelLabel;
    UIImageView *_likeImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}
#pragma mark - pickUpWindow
-(void)initSubView{
    _backImage  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, URLImage_WIDTH, URLImage_HEIGHT)];
    //_backImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_backImage];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 20, 10,SCREEN_WIDTH - URLImage_WIDTH -20 , 50)];
    //_titleLabel.backgroundColor = [UIColor orangeColor];
    _titleLabel.numberOfLines = 0;
    [self.contentView addSubview:_titleLabel];
    _modelLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 130, 70, 100, 20)];
    //8_modelLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_modelLabel];
        
    
}
-(void)passValue:(NSDictionary *)dic{
    _titleLabel.text = dic[@"newsTitle"];
    _titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    //_titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _modelLabel.text = dic[@"newsCategory"];
    NSString *str = dic[@"newsImage"];
    NSURL *imageUrl = [NSURL URLWithString:str];
    [_backImage sd_setImageWithURL:imageUrl];
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
