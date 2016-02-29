//
//  AppDelegate.h
//  MrCar
//
//  Created by xalo on 15/10/9.
//  Copyright (c) 2015年 Beijing ThinkOver. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASIDownloadCache;

#import <CoreData/CoreData.h>
#import "ITRAirSideMenu.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>


@property(nonatomic,retain)ASIDownloadCache *myCache;
@property ITRAirSideMenu *itrAirSideMenu;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

