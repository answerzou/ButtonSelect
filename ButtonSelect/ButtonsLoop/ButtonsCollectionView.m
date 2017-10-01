//
//  ButtonsCollectionView.m
//  ButtonsLoop
//
//  Created by answer.zou on 17/8/26.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

#import "ButtonsCollectionView.h"
#import "ButtonsFlowLayout.h"

#define SCALE  [UIScreen mainScreen].bounds.size.height  / 568.0

#define SeletedColor [UIColor colorWithRed:44/255.0 green:155/255.0 blue:246/255.0 alpha:1]

#define IndexPathForRow 2

static NSString * identifier = @"collecitonView_cell";


@interface ButtonsCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *mainCollectionView;

@property(nonatomic, assign)NSInteger itemCount;

@property(nonatomic, assign)CGRect collectionViewFrame;

@property(nonatomic, strong)NSArray *dataSource;

@property(nonatomic, strong)NSIndexPath *targetIndexPath;

@property(nonatomic, strong)NSArray *realArray;
@end

@implementation ButtonsCollectionView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.itemCount = dataSource.count;
        self.collectionViewFrame = frame;
        self.dataSource = dataSource;
        [self createCollectionViewStyle];
        self.mainCollectionView.delegate  = self;
        self.mainCollectionView.dataSource = self;
        self.mainCollectionView.allowsSelection = false;
        self.mainCollectionView.showsHorizontalScrollIndicator = NO;
        self.mainCollectionView.backgroundColor = [UIColor whiteColor];
        [self.mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:IndexPathForRow inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionIndexPath:) name:@"CollectionViewIndexPath" object:nil];;
    }
    return self;
}

-(void)createCollectionViewStyle {
    
    UICollectionViewFlowLayout *layout = [[ButtonsFlowLayout alloc] initWithFrame:self.collectionViewFrame dataSource:self.dataSource];
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

    [self addSubview:self.mainCollectionView];
    
    //注册cell
    [self.mainCollectionView registerClass:[UICollectionViewCell class]
                forCellWithReuseIdentifier:identifier];
}

- (NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemCount;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = ({
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
//        cell.backgroundColor = [UIColor lightGrayColor];
        cell.layer.masksToBounds = YES;
        cell.layer.cornerRadius = 60 * 0.5;
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = [UIColor grayColor].CGColor;
        cell;
    });
    
    
    UILabel *la = ({
        
       UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 60, 20)];
        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor orangeColor];
        label.font = [UIFont systemFontOfSize:21];
        label.textColor = [UIColor grayColor];
        label.text = self.dataSource[indexPath.row];
        if (!self.targetIndexPath) {
            if (indexPath.row == IndexPathForRow) {
//                label.backgroundColor = [UIColor orangeColor]; UIColor(red: 44/255.0, green: 155/255.0, blue: 246/255.0, alpha: 1)

                cell.layer.borderColor = [UIColor whiteColor].CGColor;
                 cell.selected = YES;
                cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home_buttosSelect"]];
                label.textColor = SeletedColor;
            }
        }
        label;
        
    });
    
    [cell.contentView addSubview:la];
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSLog(@"contentOffset:%f", scrollView.contentOffset.x);
//    for (UICollectionViewCell *cell in self.mainCollectionView.visibleCells) {
//        cell.backgroundView = nil;
//    }
    
    NSLog(@"%@", self.targetIndexPath);
    
    if (self.selectedIndex) {
        self.selectedIndex(self.targetIndexPath.row);
    }
    
    UICollectionViewCell *cell = [self.mainCollectionView cellForItemAtIndexPath:self.targetIndexPath];
    cell.selected = YES;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_home_buttosSelect"]];

    for (UIView *view in cell.contentView.subviews) {
        UILabel *label = (UILabel *)view;
        label.textColor = SeletedColor;
    }
}

-(void)collectionIndexPath: (NSNotification *)noti {
    NSIndexPath *indexPath = noti.object;
    NSLog(@"---%ld", indexPath.row);
    [self.mainCollectionView reloadData];
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row + 2 inSection:0];
    self.targetIndexPath = index;
    
}




@end
