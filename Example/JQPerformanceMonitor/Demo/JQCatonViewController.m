//
//  JQCatonViewController.m
//  JQUIKit_Example
//
//  Created by jiaqian wang on 2021/11/24.
//  Copyright © 2021 vidonia. All rights reserved.
//

#import "JQCatonViewController.h"
#import "JQTableViewModel.h"
#import "JQTableViewCellModel.h"
#import "JQTableViewSectionModel.h"
#import "JQLargeImgTableViewCell.h"
#import "SDWebImage.h"
#import "JQCatonMonitor.h"

@interface JQCatonViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JQTableViewModel *viewModel;
@end

@implementation JQCatonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"卡顿监控";
    
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))];
    [self.view addSubview:self.tableView];
    
    self.viewModel = [JQTableViewModel modelWithTableView:self.tableView];
    
    [self loadCellModel];
    
}



- (void)loadCellModel {
    JQTableViewSectionModel *sectionModel = [[JQTableViewSectionModel alloc] init];
    [self.viewModel.sectionModelList addObject:sectionModel];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"jpeg"];

    NSString *a = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2Fv2-956295fc660aee9127c9ecb4b9b32090_r.jpg%3Fsource%3D1940ef5c&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640243878&t=c1a6ffe8184c3e560d077a374d6935d1";
    NSString *b = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic2.zhimg.com%2Fv2-111fb63210cb2b7fe01d6c5a7cc4d07a_r.jpg%3Fsource%3D1940ef5c&refer=http%3A%2F%2Fpic2.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640244051&t=e73a3003be4760d3b803ec5f630b7e22";
    NSString *c = @"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.zhimg.com%2Fv2-565c3f6ab6e3082cd91743dd1453a257_r.jpg%3Fsource%3D1940ef5c&refer=http%3A%2F%2Fpic1.zhimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1640244089&t=72db7936d04cf12d644b3d8e5aa81abc";

    for (int i = 0; i < 400; i++) {
        JQTableViewCellModel *cellModel = [JQTableViewCellModel new];
        [sectionModel.cellModelList addObject:cellModel];
        cellModel.cellHeight = 200;
        cellModel.renderCellHandler = ^UITableViewCell * _Nonnull(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableview, JQTableViewCellModel * _Nonnull cellModel) {
            JQLargeImgTableViewCell *cell = [JQLargeImgTableViewCell largeImgCell:tableview];
            cell.titleLabel.text = [NSString stringWithFormat:@"第 %ld 行", indexPath.row + 1];
            cell.index = indexPath.row;
//            [cell.largeImgView1 sd_setImageWithURL:[NSURL URLWithString:a]];
//            [cell.largeImgView2 sd_setImageWithURL:[NSURL URLWithString:b]];
//            [cell.largeImgView3 sd_setImageWithURL:[NSURL URLWithString:c]];
//            cell.largeImgView1.image = [UIImage imageWithContentsOfFile:path];
//            cell.largeImgView2.image = [UIImage imageWithContentsOfFile:path];
//            cell.largeImgView3.image = [UIImage imageWithContentsOfFile:path];
            return cell;
        };
        
        cellModel.cellSelectedHandler = ^(NSIndexPath * _Nonnull indexPath, UITableView * _Nonnull tableview, UITableViewCell * _Nonnull cell) {
            JQLargeImgTableViewCell *imgCell = (JQLargeImgTableViewCell *)cell;
            NSLog(@"%@", imgCell.titleLabel.text);
            int a = 8;
            NSLog(@"调试：大量计算");
            for (long i = 0; i < 999999999; i++) {
                a = a + 1;
            }
            NSLog(@"调试：大量计算结束");
        };
    }
    
//    [NSTimer scheduledTimerWithTimeInterval:0.001 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"Timer：大量计算");
//        int a = 8;
//        for (long i = 0; i < 999999999; i++) {
//            a = a + 1;
//        }
//        NSLog(@"Timer：大量计算结束");
//    }];
}



@end
