//
//  JQLargeImgTableViewCell.m
//  JQUIKit_Example
//
//  Created by jiaqian wang on 2021/11/23.
//  Copyright © 2021 vidonia. All rights reserved.
//

#import "JQLargeImgTableViewCell.h"

@implementation JQLargeImgTableViewCell

+ (instancetype)largeImgCell:(UITableView *)tableView {
    NSString *reuseIdentifier = NSStringFromClass([self class]);
    JQLargeImgTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[JQLargeImgTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 200, 20)];
        [self.contentView addSubview:self.titleLabel];

        CGFloat width = (CGRectGetWidth([UIScreen mainScreen].bounds) - 80)/3.0;
        self.largeImgView1 = [[UIImageView alloc] initWithFrame:(CGRectMake(20, CGRectGetMaxY(self.titleLabel.frame) + 20, width, 100))];
        self.largeImgView1.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:self.largeImgView1];
        
        self.largeImgView2 = [[UIImageView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(self.largeImgView1.frame) + 20, CGRectGetMinY(self.largeImgView1.frame), CGRectGetWidth(self.largeImgView1.frame), CGRectGetHeight(self.largeImgView1.frame)))];
        self.largeImgView2.backgroundColor = [UIColor systemPinkColor];
        [self.contentView addSubview:self.largeImgView2];
        
        
        self.largeImgView3 = [[UIImageView alloc] initWithFrame:(CGRectMake(CGRectGetMaxX(self.largeImgView2.frame)+20, CGRectGetMinY(self.largeImgView1.frame), CGRectGetWidth(self.largeImgView1.frame), CGRectGetHeight(self.largeImgView1.frame)))];
        self.largeImgView3.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.largeImgView3];
    }
    return self;
}



@end
