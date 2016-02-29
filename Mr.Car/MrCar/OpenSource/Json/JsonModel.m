//
//  JsonModel.m
//  MrCar
//
//  Created by xalo on 15/10/10.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import "JsonModel.h"
#import <UIKit/UIKit.h>
@implementation JsonModel

-(void)getRequestMethodWithUrlString:(NSString *)urlString parameter:(NSString *)parameter{
    NSMutableString *urlMutableString = [[NSMutableString alloc]initWithString:urlString];
    if (parameter) {
        [urlMutableString appendString:parameter];
    }
    NSURL *url = [NSURL URLWithString:urlMutableString];
    //缓存策略
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:20.0];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查网络连接" delegate:self cancelButtonTitle:@"确定"  otherButtonTitles:nil, nil];
           [alertView show];
        } else {
            NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.passValueBlock(jsonDic);
            

        }
    }];
}

-(void)getArrRequestMethodWithUrlString:(NSString *)urlString parameter:(NSString *)parameter{
    NSMutableString *urlMutableString = [[NSMutableString alloc] initWithString:urlString];
    if (parameter) {
        [urlMutableString appendString:parameter];
    }
    NSURL *url = [NSURL URLWithString:urlMutableString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
#pragma mark - UTF-8
        //NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //NSInteger index = [content rangeOfString:@"["].location;
        //content = [content substringFromIndex:index];
       // NSArray *jsonArr  = [NSJSONSerialization JSONObjectWithData:[content dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSArray *jsonArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.passBlock(jsonArr);
        //        NSLog(@"%@", jsonArr);
    }];

}
@end
