//
//  JQLargeImgTableViewCell.h
//  JQUIKit_Example
//
//  Created by jiaqian wang on 2021/11/23.
//  Copyright © 2021 vidonia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JQLargeImgTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *largeImgView1;
@property (nonatomic, strong) UIImageView *largeImgView2;
@property (nonatomic, strong) UIImageView *largeImgView3;
@property (nonatomic, assign) NSInteger index;

+ (instancetype)largeImgCell:(UITableView *)tableView;


@end

NS_ASSUME_NONNULL_END
