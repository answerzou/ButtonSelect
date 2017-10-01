//
//  ButtonsFlowLayout.m
//  ButtonsLoop
//
//  Created by answer.zou on 17/8/26.
//  Copyright © 2017年 answer.zou. All rights reserved.
//

#import "ButtonsFlowLayout.h"

#define LEFT_OFFSET 60
#define SCALE  [UIScreen mainScreen].bounds.size.height / 568.0
#define ItemSizeWidth  60

@interface ButtonsFlowLayout ()

@property(nonatomic, strong)NSArray *dataSource;
@property(nonatomic, strong)NSIndexPath *myIndexPath;

@end

@implementation ButtonsFlowLayout

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource
{
    self = [super init];
    if (self)
    {
        
        self.itemSize = CGSizeMake(ItemSizeWidth, ItemSizeWidth);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置为水平滑动
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - self.itemSize.width * 5) / 6;
        self.minimumLineSpacing = margin;
        
        CGFloat leftAndRightMargin = ([UIScreen mainScreen].bounds.size.width - self.itemSize.width) * 0.5;
        self.sectionInset = UIEdgeInsetsMake(10, leftAndRightMargin, 10, leftAndRightMargin);
        self.dataSource = dataSource;
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    //获取当前显示cell的布局
    NSArray *attributes = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        //计算中心点距离
        
        
       CGFloat delta = ABS( self.collectionView.bounds.size.width * 0.5 -(attribute.center.x - self.collectionView.contentOffset.x));
        
        //计算比例
        CGFloat scale = 1 -  delta / (self.collectionView.bounds.size.width * 0.5) * 0.6;
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
        attribute.alpha = scale;
    }
    
    return attributes;
}

- (CGPoint )targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter_X = proposedContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2.0;
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes * attributes in array)
    {
        CGFloat itemHorizontalCenter_X = attributes.center.x;
        if (ABS(itemHorizontalCenter_X - horizontalCenter_X) < ABS(offsetAdjustment))
        {
            offsetAdjustment = itemHorizontalCenter_X - horizontalCenter_X;
        }
    }
    
    NSLog(@"xxx%f", proposedContentOffset.x + offsetAdjustment);
    
    
    NSArray *attributes = [super layoutAttributesForElementsInRect:CGRectMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y, self.itemSize.width, self.itemSize.height)];
    
    //判断前两种情况
    
    if (attributes.count == 0) {
        
        if (proposedContentOffset.x + offsetAdjustment <= 1) {
            NSLog(@"选中的数字:%@", self.dataSource[0]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CollectionViewIndexPath" object:[NSIndexPath indexPathForRow:0 - 2 inSection:0]];
        }else {
            NSLog(@"选中的数字:%@", self.dataSource[1]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CollectionViewIndexPath" object:[NSIndexPath indexPathForRow:1 - 2 inSection:0]];
        }
    }
    
    for (UICollectionViewLayoutAttributes * attribute in attributes)
    {
        
        //选中的数字
        NSLog(@"选中的数字:%@", self.dataSource[attribute.indexPath.row + 2]);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CollectionViewIndexPath" object:attribute.indexPath];
        
        NSLog(@"count: %lu", (unsigned long)attributes.count);

    }
    
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}



@end
