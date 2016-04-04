//
//  TopicDetailCollectionViewFlowLayout.m
//  PinGo
//
//  Created by 新新希冀 on 16/3/30.
//  Copyright © 2016年 Linjianping's Awesome App House. All rights reserved.
//

#import "TopicDetailCollectionViewFlowLayout.h"
#import "NSString+Age.h"

typedef struct Column {
    NSInteger index;//列号
    CGFloat  height; // 列高
}Column;

@interface TopicDetailCollectionViewFlowLayout ()

@property (nonatomic,copy) NSMutableArray *layoutAttributes;// 布局属性数组
@property (nonatomic,copy) NSMutableArray *colItemHeightValues;//列高属性

@end

@implementation TopicDetailCollectionViewFlowLayout

int rowItemNum=2;//一行显示的item个数
- (void)prepareLayout{
    [super prepareLayout];
    CGFloat fRowItemNum=(CGFloat)rowItemNum;
    NSInteger itemWidth=(kScreenWidth - (fRowItemNum-1)*self.minimumInteritemSpacing-self.sectionInset.left-self.sectionInset.right)/fRowItemNum;
    [self calcAllItemLayoutAttributeByItemWidth:itemWidth];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutAttributes;
}
// 设置collectionView的滚动范围
- (CGSize)collectionViewContentSize{
    CGFloat y=[[self.colItemHeightValues sortedArrayUsingComparator:cmptr].lastObject floatValue]-self.minimumInteritemSpacing;
    return CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), y+self.sectionInset.bottom);
}

NSComparator cmptr = ^(id obj1, id obj2){
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedSame;
};

// MARK: lazy loading
/// 布局属性数组
- (NSMutableArray *)layoutAttributes{
    if (!_layoutAttributes) {
        _layoutAttributes=[NSMutableArray new];
    }
    return _layoutAttributes;
}

/// 列高数组
- (NSMutableArray *)colItemHeightValues{
    if (!_colItemHeightValues) {
        _colItemHeightValues=[NSMutableArray new];
        for (int i=0; i<rowItemNum; i++) {
            NSNumber *h=[NSNumber numberWithFloat:self.sectionInset.top];
            [_colItemHeightValues addObject:h];
        }
    }
  return _colItemHeightValues;
}

/**
 计算所有item的布局属性
 */
- (void)calcAllItemLayoutAttributeByItemWidth:(CGFloat)itemWidth{
    if (!self.topicInfoList) {
        return;
    }
//    int index=0;
    for (int index=0; index<self.topicInfoList.count; index++) {
        UICollectionViewLayoutAttributes *attribute=[self calcItemLayoutAttributeWithIndex:index andItemWidth:itemWidth];
        [self.layoutAttributes addObject:attribute];
    }
}

/**
 计算一个item的布局属性
 */
- (UICollectionViewLayoutAttributes *)calcItemLayoutAttributeWithIndex:(NSInteger)index andItemWidth:(CGFloat)itemWidth{
    // 创建布局属性
    UICollectionViewLayoutAttributes *attribute=[UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    
    // 高度最小的列号和列高
    Column minCol=[self findMinHeightColIndexAndHeight];
    
    CGFloat x=self.sectionInset.left+minCol.index*(itemWidth+self.minimumInteritemSpacing);
    CGFloat y=minCol.height;
    CGFloat h=[self calcItemHeightWithIndex:index andWidth:itemWidth];
    
    // 将item的高度添加到数组进行记录
    CGFloat oldHeight=[self.colItemHeightValues[minCol.index] floatValue];
    self.colItemHeightValues[minCol.index]=[NSNumber numberWithFloat:(oldHeight+h+self.minimumLineSpacing)];
    
    // 设置frame
    attribute.frame=CGRectMake(x, y, itemWidth, h);
    return attribute;
}

/**
 根据数据源中的宽高计算等比例的高度
 
 :returns: item的高度
 */
- (CGFloat)calcItemHeightWithIndex:(NSInteger)index andWidth:(CGFloat)width{
    CGFloat bgImageH=width*4.0/3.0;
    CGFloat descLabelH=10;//底部文字默认高度
    NSString *desc=self.topicInfoList[index].content;
    if (desc) {
        descLabelH=[NSString sizeWithText:desc withFont:[UIFont fontWithSize:10] andMaxSize:CGSizeMake(width, MAXFLOAT)].height;
    }
    CGFloat userIconH=25;// 头像高度
    CGFloat margin=5;
    return margin+userIconH+margin+bgImageH+margin+descLabelH+margin;
}

/**
 找出高度最小的列
 
 - returns: 列号和列高
 */
- (Column)findMinHeightColIndexAndHeight{
    CGFloat minHeight=[self.colItemHeightValues[0] floatValue];
    NSInteger index=0;
    for (int i=0; i<rowItemNum; i++) {
        CGFloat h=[self.colItemHeightValues[i] floatValue];
        if (minHeight>h) {
            minHeight=h;
            index=i;
        }
    }
    Column col={index,minHeight};
    return col;
}





@end

