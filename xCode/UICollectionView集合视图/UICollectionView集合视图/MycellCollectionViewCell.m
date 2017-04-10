//
//  MycellCollectionViewCell.m
//  UICollectionView集合视图
//
//  Created by Aseven on 2017/4/9.
//  Copyright © 2017年 Aseven. All rights reserved.
//

#import "MycellCollectionViewCell.h"

@implementation MycellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    _label.textColor=[UIColor darkTextColor];
    _label.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:_label];
}


@end
