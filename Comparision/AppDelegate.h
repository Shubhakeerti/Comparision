//
//  AppDelegate.h
//  Comparision
//
//  Created by Shubhakeerti Alagundagi on 30/06/15.
//  Copyright (c) 2015 Shubhakeerti Alagundagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic, strong) DBManager *dbManager;


@end

