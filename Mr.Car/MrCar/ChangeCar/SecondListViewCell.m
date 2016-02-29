//
//  SecondListViewCell.m
//  MrCar
//
//  Created by xalo on 15/10/12.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "SecondListViewCell.h"
#import "UIImageView+WebCache.h"
#import "JsonModel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//获取当前屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//获取当前屏幕高度


@implementation SecondListViewCell
{
    UIImageView *_cellImage;
    UILabel *_titleLabel;
    UILabel *_topLabel;
    UIImageView *_likeImage;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    _cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH,250)];
    _cellImage.clipsToBounds = YES;
    _cellImage.alpha  = 1;
    [self.contentView addSubview:_cellImage];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH, 25)];
    _titleLabel.numberOfLines = 0;
    [_cellImage addSubview:_titleLabel];
    
    _likeImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 230, 30, 20)];
//    _likeImage.image = [UIImage imageNamed:@"103.png"];
    //Xcode插件KSImageNamed使用
    _likeImage.image = [UIImage imageNamed:@"103.png"];
//    _likeImage.image = [UIImage imageNamed:]
    
    [self.contentView addSubview:_likeImage];
    
    _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 227, 40, 20)];
    _topLabel.numberOfLines = 0;
    [_cellImage addSubview:_topLabel];
    
    
}
-(void)passValue:(NSDictionary *)dic{
    _titleLabel.text = dic[@"name"];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    _topLabel.text = [dic[@"top_count"] stringValue];
    _topLabel.textColor = [UIColor whiteColor];

    NSString *str = dic[@"cover"];
    NSURL *imageUrl = [NSURL URLWithString:str];
   // NSMutableArray *images = [NSMutableArray array];
//    for (int i = 1; i < 16; i++) {
//        NSString *name = [NSString stringWithFormat:@"pp%d.tiff",i];
//        UIImage *image = [UIImage imageNamed:name];
//        [images addObject:image];
//        _cellImage.animationImages = images;
    UIImage *image = [UIImage imageNamed:@"/Users/tangjunfeng/Desktop/MrCar/MrCar/Picture/placeHolderImage/pp1.tiff"];
        _cellImage.animationDuration = 1;
        [_cellImage sd_setImageWithURL:imageUrl placeholderImage:image];

    
    

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
