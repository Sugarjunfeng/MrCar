//
//  JsonModel.h
//  MrCar
//
//  Created by xalo on 15/10/10.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonModel : NSObject
@property (nonatomic, copy) void (^passBlock)(NSArray *);

@property(nonatomic,copy)void(^passValueBlock)(NSDictionary *);


- (void)getRequestMethodWithUrlString:(NSString *)urlString
                            parameter:(NSString *)parameter;

- (void)getArrRequestMethodWithUrlString:(NSString *)urlString
                            parameter:(NSString *)parameter;


@end
