//
//  ThirdViewCell.h
//  MrCar
//
//  Created by xalo on 15/10/13.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewCell : UITableViewCell
-(void)passValue:(NSDictionary *)dic;
@property(nonatomic,retain)NSDictionary *data;
@end
