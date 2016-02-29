//
//  ThirdViewCell.m
//  MrCar
//
//  Created by xalo on 15/10/13.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "ThirdViewCell.h"
#import "UIImageView+WebCache.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//获取当前屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//获取当前屏幕高度
#define URLImage_WIDTH 110
#define URLImage_HEIGHT 120

@implementation ThirdViewCell
{
    UILabel *_shopLabel;//商家
    UILabel *_titleLabel;//标题
    UILabel *_priceLabel;//价格
    UILabel *_commentLabel;//评论
    UILabel *_commentNum;//评论数
    UILabel *_timeLabel;//时间
    UIImageView *_thingImage;//商品图片
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    //商品图片
    _thingImage  = [[UIImageView alloc]initWithFrame:CGRectMake(5, 15, URLImage_WIDTH, URLImage_HEIGHT)];
    //_thingImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_thingImage];
    //商家
    _shopLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 15, 5, 120, 15)];
    //_shopLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_shopLabel];
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 15, 30,SCREEN_WIDTH - URLImage_WIDTH - 20, 50)];
    _titleLabel.numberOfLines = 0;
   // _titleLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_titleLabel];
    //价格
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 15, 80, 100, 30)];
   // _priceLabel.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:_priceLabel];
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 145, 85, 70, 20)];
    //_timeLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_timeLabel];
    //评论
    _commentLabel = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 15, 125, 40, 10)];
    _commentLabel.text = @"评论:";
    _commentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    [self.contentView addSubview:_commentLabel];
    //评论数
    _commentNum = [[UILabel alloc]initWithFrame:CGRectMake(URLImage_WIDTH + 55, 123, 40, 15)];
   // _commentNum.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_commentNum];
    
}
-(void)passValue:(NSDictionary *)dic{
    UIImage *image = [UIImage imageNamed:@"third1.png"];
    NSString *str = dic[@"article_pic"];
    NSURL *imageUrl = [NSURL URLWithString:str];
    [_thingImage sd_setImageWithURL:imageUrl placeholderImage:image];
    _shopLabel.text = dic[@"article_mall"];
    _shopLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _shopLabel.tintColor = [UIColor grayColor];
    _titleLabel.text = dic[@"article_title"];
    _priceLabel.text = dic[@"article_price"];
    _priceLabel.textColor = [UIColor redColor];
    _timeLabel.text = dic[@"article_format_date"];
    _commentNum.text = dic[@"article_comment"];
    _commentNum.font = [UIFont fontWithName:@"HelveticaNeue" size:14];

}
    
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
