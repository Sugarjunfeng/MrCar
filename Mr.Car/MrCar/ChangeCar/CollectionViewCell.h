//
//  CollectionViewCell.h
//  MrCar
//
//  Created by xalo on 15/10/13.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)UIView *itemView;
@property(nonatomic,retain)UIImageView *carImage;
@property(nonatomic,retain)UITextView *textView;
@end
