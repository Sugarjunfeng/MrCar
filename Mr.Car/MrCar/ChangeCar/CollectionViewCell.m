//
//  CollectionViewCell.m
//  MrCar
//
//  Created by xalo on 15/10/13.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)//获取当前屏幕宽度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)//获取当前屏幕高度

@implementation CollectionViewCell
{
    UIImageView *_textImage;
}
//frame为item的大小
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        _itemView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//        _itemView.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:_itemView];
        _carImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 170)];
        //_carImage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_carImage];
        
        //标题背景
        _textImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,170, frame.size.width, 50)];
        //_textImage.backgroundColor = [UIColor blueColor];
        
        _textImage.image = [UIImage imageNamed:@"0007.png"];
        [self.contentView addSubview:_textImage];
        
        //文字
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 220, frame.size.width, frame.size.height - 170 - 50)];
//        _textView.userInteractionEnabled = NO;
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = [UIColor grayColor];
        _textView.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        [self.contentView addSubview:_textView];
        
    }
    return self;
}

@end
