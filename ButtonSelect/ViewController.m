//
//  ViewController.m
//  ButtonSelect
//
//  Created by BJJY on 2017/10/1.
//  Copyright © 2017年 捷越联合. All rights reserved.
//

#import "ViewController.h"
#import "ButtonsCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataSource = @[@"12", @"18", @"24", @"36"];
    ButtonsCollectionView *buttons = [[ButtonsCollectionView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 80) dataSource:dataSource];
    
    [self.view addSubview:buttons];

    /*
     buttonsLoop.selectedIndex = { (selectIndex) in
     
     JYAPPLog(self.loanTimes[selectIndex])
     self.loanTimeSelected = self.loanTimes[selectIndex] as! String
     
     }
     */
    buttons.selectedIndex = ^(NSInteger index) {
        NSLog(@"%ld", (long)index);
    };
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
