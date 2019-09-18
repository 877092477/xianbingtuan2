//
//  FNPartnerCenterView.m
//  SuperMode
//
//  Created by jimmy on 2017/10/16.
//  Copyright © 2017年 方诺科技. All rights reserved.
//

#import "FNPartnerCenterView.h"
#import "FNPartnerCenterViewModel.h"
#import "FNPartnerCenterCell.h"
#import "FNPartnerCenterHeader.h"
@interface FNPartnerCenterView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)FNPartnerCenterViewModel* viewmodel;
@property (nonatomic, strong)FNPartnerCenterHeader* header;
@end
@implementation FNPartnerCenterView

- (instancetype)initWithViewModel:(id<JMViewModelProtocol>)viewModel{
    self.viewmodel =(FNPartnerCenterViewModel *) viewModel;
    return  [super initWithViewModel:viewModel];
}

#pragma mark - initializedSubviews
- (void)jm_setupViews
{
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 1;
    flowlayout.minimumInteritemSpacing = 1;
    flowlayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:flowlayout];
//    self.jm_collectionview.alpha = 0;
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.backgroundColor = FNHomeBackgroundColor;
    [self.jm_collectionview registerClass:[FNPartnerCenterCell class] forCellWithReuseIdentifier:@"FNPartnerCenterCell"];
    [self.jm_collectionview registerClass:[FNPartnerCenterHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FNPartnerCenterHeader"];
    [self addSubview:self.jm_collectionview];
    [self.jm_collectionview autoPinEdgesToSuperviewEdgesWithInsets:(UIEdgeInsetsZero)];
}
- (void)jm_bindViewModel{
    @weakify(self);
    [SVProgressHUD show];
    [self.viewmodel.refreshDataCommand execute:nil];
    [[self.viewmodel.refreshUI takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self);
        
        [self.jm_collectionview reloadData];
//        [UIView animateWithDuration:1.0 animations:^{
//            self.jm_collectionview.alpha = 1;
//        }];
    }];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.viewmodel.CenterIconModel.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FNPartnerCenterCell* cell = [FNPartnerCenterCell cellWithCollectionView:collectionView atIndexPath:indexPath];
    [cell.iconimgview setUrlImg:self.viewmodel.CenterIconModel[indexPath.item].img];
    cell.titleLabel.text = self.viewmodel.CenterIconModel[indexPath.item].name;
    cell.subLabel.text = self.viewmodel.CenterIconModel[indexPath.item].content;
    cell.backgroundColor = FNWhiteColor;
    if (self.viewmodel.model && cell.subLabel && cell.subLabel.text.length>=1) {
        [cell.subLabel addSingleAttributed:@{NSForegroundColorAttributeName:FNMainGobalControlsColor} ofRange:[cell.subLabel.text rangeOfString:self.viewmodel.model.count]];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    self.header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FNPartnerCenterHeader" forIndexPath:indexPath];
    [self.header.avatarimgview setUrlImg:self.viewmodel.model.head_img];
    self.header.nameLabel.text = self.viewmodel.model.nickname;
    self.header.memberLabel.text = self.viewmodel.model.Vname;
    return self.header;
}


#pragma mark - Collection view delegate && flow layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size = CGSizeMake(floorf((JMScreenWidth-4)/3.0), JMScreenWidth/3);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = CGSizeMake(JMScreenWidth, JMNavBarHeigth*0.5+_pch_avatar_h+_jmsize_10*4+17*2);
    return size;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewmodel.cellClickSubject sendNext:self.viewmodel.CenterIconModel[indexPath.item]];
}
@end
