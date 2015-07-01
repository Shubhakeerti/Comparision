//
//  ViewController.h
//  Comparision
//
//  Created by Shubhakeerti Alagundagi on 30/06/15.
//  Copyright (c) 2015 Shubhakeerti Alagundagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *syncButton;
@property (weak, nonatomic) IBOutlet UIButton *fetchFromDBButton;
@property (weak, nonatomic) IBOutlet UILabel *syncLabel;

@end

