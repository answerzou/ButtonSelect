//
//  ButtonsCollectionView.h
//  ButtonsLoop
//
//  Created by answer.zou on 17/8/26.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonsCollectionView : UIView
    
typedef void(^SelectedIndex)(NSInteger index);
    
@property (nonatomic, copy)SelectedIndex selectedIndex;

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource;

@end
