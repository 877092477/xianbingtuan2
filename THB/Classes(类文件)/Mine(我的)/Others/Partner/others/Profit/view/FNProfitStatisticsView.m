//
//  FNProfitStatisticsView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/17.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNProfitStatisticsView.h"
#import "FNProfitStatisticsViewModel.h"
#import "FNProfitStatisticsCell.h"
#import "FNDoubleLabelCell.h"
#import "FNPSBalanceCell.h"
#import "FNPSDateCell.h"
@interface FNProfitStatisticsView()
@property (nonatomic, strong)FNProfitStatisticsViewModel* viewmodel;
@end
@implementation FNProfitStatisticsView

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNProfitStatisticsViewModel*) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    self.jm_tableview.alpha = 0;
    [self addSubview:self.jm_tableview];
    [self.jm_tableview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    @weakify(self);
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        [self.jm_tableview reloadData];
        [UIView animateWithDuration:1.0 animations:^{
            self.jm_tableview.alpha = 1;
        }];
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray* array = self.viewmodel.datas[section];
    return array.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewmodel.datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @weakify(self);
    if (indexPath.section == 0) {
     
        if (indexPath.row == 2) {
            FNPSBalanceCell* cell = [FNPSBalanceCell cellWithTableView:tableView atIndexPath:indexPath];
            
            NSString *is_tx=[[NSUserDefaults standardUserDefaults] objectForKey:@"JM_MPM_wallet_is_tx"];
            if ([NSString checkIsSuccess:is_tx andElement:@"1"]) {
                CGFloat width = (JMScreenWidth-15*2)*0.5;
                [cell.withdrawBtn setTitle:self.viewmodel.model.str1 forState:UIControlStateNormal];
                [cell.withdrawBtn sizeToFit];
                cell.withdrawBtn.width=cell.withdrawBtn.width+_jmsize_10*2;
                cell.withdrawBtn.cornerRadius = (cell.withdrawBtn.height)*0.5;
                [cell.withdrawBtn autoSetDimensionsToSize:cell.withdrawBtn.size];
                [cell.withdrawBtn autoAlignAxisToSuperviewAxis:(ALAxisHorizontal)];
                [cell.withdrawBtn autoPinEdgeToSuperviewEdge:(ALEdgeRight) withInset:15+(width-cell.withdrawBtn.width-_jmsize_10*2)*0.5];
            }
            
            cell.titleLabel.text = self.viewmodel.datas[indexPath.section][indexPath.row][0];
            [cell.leftBtn.bottomLabel setTitle:self.viewmodel.datas[indexPath.section][indexPath.row][1] forState:(UIControlStateNormal)];
            [cell.rightBtn.bottomLabel setTitle:self.viewmodel.datas[indexPath.section][indexPath.row][2] forState:(UIControlStateNormal)];
            cell.withdrawBlock = ^{
                @strongify(self);
                [self.viewmodel.withdrawsubject sendNext:self.viewmodel.model.tx_url];
            };
            NSString*left = self.viewmodel.contents[indexPath.section][indexPath.row][1];
            NSString*right = self.viewmodel.contents[indexPath.section][indexPath.row][2];
            [cell.leftBtn.topLable setTitle:left forState:(UIControlStateNormal)];
            [cell.rightBtn.topLable setTitle:right forState:(UIControlStateNormal)];
            [cell.leftBtn.topLable setAttributedTitle:[NSString attributedStringWithString:left attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
            [cell.rightBtn.topLable setAttributedTitle:[NSString attributedStringWithString:right attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
            [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:cell.leftBtn.topLable];
            [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:cell.rightBtn.topLable];
            return  cell;
        }else if (indexPath.row <=1){
            FNProfitStatisticsCell* cell = [FNProfitStatisticsCell cellWithTableView:tableView atIndexPath:indexPath];
            cell.titleLabel.text = self.viewmodel.datas[indexPath.section][indexPath.row][0];
            [cell.leftBtn.bottomLabel setTitle:self.viewmodel.datas[indexPath.section][indexPath.row][1] forState:(UIControlStateNormal)];
            [cell.rightBtn.bottomLabel setTitle:self.viewmodel.datas[indexPath.section][indexPath.row][2] forState:(UIControlStateNormal)];
            
            NSString*left = self.viewmodel.contents[indexPath.section][indexPath.row][1];
            NSString*right = self.viewmodel.contents[indexPath.section][indexPath.row][2];
            [cell.leftBtn.topLable setTitle:left forState:(UIControlStateNormal)];
            [cell.rightBtn.topLable setTitle:right forState:(UIControlStateNormal)];
            [cell.leftBtn.topLable setAttributedTitle:[NSString attributedStringWithString:left attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
            [cell.rightBtn.topLable setAttributedTitle:[NSString attributedStringWithString:right attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES] forState:(UIControlStateNormal)];
            [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:cell.leftBtn.topLable];
            [self HttpImage:[FNBaseSettingModel settingInstance].mon_icon Btn:cell.rightBtn.topLable];
            return cell;
        }else{
            FNPSDateCell* cell = [FNPSDateCell cellWithTableView:tableView atIndexPath:indexPath];
            cell.datas = self.viewmodel.model.today_yes;
            return cell;
        }
    }else{
        FNDoubleLabelCell* cell = [FNDoubleLabelCell cellWithTableView:tableView atIndexPath:indexPath];
        cell.leftlabel.text = self.viewmodel.datas[indexPath.section][indexPath.row];
        cell.leftwidth = (JMScreenWidth-15*2)*0.5;
        cell.rightLabel.textAlignment  =NSTextAlignmentRight;
        cell.rightLabel.text = [NSString stringWithFormat:@"%@%@",self.viewmodel.contents[indexPath.section][indexPath.row],self.viewmodel.model.str2];
        cell.rightLabel.attributedText = [NSString attributedStringWithString:cell.rightLabel.text attributed:@{NSFontAttributeName:kFONT17} fromString:@" " toString:@"." isNotContainedFirst:YES];
        
        return cell;
    }

}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = _psc_cell_height;
    if (indexPath.section == 1) {
        height = 50;
    }else if(indexPath.section == 0 && indexPath.row == 3){
        height = _psdc_cell_height;
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//异步获取Label的图片
-(void)HttpImage:(NSString *)imgUrl Btn:(UIButton *)Btn{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:URL(imgUrl)]];
        img=[img scaleFromImage:img toSize:CGSizeMake(img.size.width/img.size.height*13, 13)];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
            [Btn setImage:img forState:UIControlStateNormal];
        });
    });
}
@end
