//
//  FNneckRedPacketNaController.m
//  THB
//
//  Created by Jimmy on 2019/2/12.
//  Copyright © 2019 方诺科技. All rights reserved.
//

#import "FNneckRedPacketNaController.h"
#import "FNCustomeNavigationBar.h"
#import "FNneckBagChiefCeCell.h"
#import "FNneckResultItemCeCell.h"
#import "FNneckTwoBagAeCell.h"
#import "FNChatManager.h"
@interface FNneckRedPacketNaController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)FNCustomeNavigationBar *topNaivgationbar;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@end

@implementation FNneckRedPacketNaController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view. 
    [self RedPacketCollectionview];
    [self setTopNavBar];
    if([self.hb_id kr_isNotEmpty]){
        if([self.target isEqualToString:@"ren"]){
           [self apiRequestOpenRedPacket];
        }else if([self.target isEqualToString:@"qun"]){
            self.jm_collectionview.hidden=NO;
        } 
    }
}
#pragma mark - 导航栏view
-(void)setTopNavBar{
    
    self.topNaivgationbar = [FNCustomeNavigationBar customeNavigationBarWithCustomeView:nil];
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.leftBtn setImage:[UIImage imageNamed:@"return_w"] forState:UIControlStateNormal];
    if([self.name kr_isNotEmpty]){
       //[self.leftBtn setTitle:self.name forState:UIControlStateNormal];
    }
    [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font=kFONT17;
    [self.leftBtn sizeToFit];
    self.leftBtn.size = CGSizeMake(self.leftBtn.width+10, 30);
    [self.leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.leftBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10.0f];
    self.topNaivgationbar.leftButton = self.leftBtn;
    
    self.rightBtn= [UIButton buttonWithType:(UIButtonTypeCustom)];
   
    //[self.rightBtn setTitle:@"红包详情" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font=kFONT14;
    [self.rightBtn sizeToFit];
    self.rightBtn.size = CGSizeMake(self.rightBtn.width+10, 30);
    [self.rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.topNaivgationbar.rightButton = self.rightBtn;
    
    [self.view addSubview:_topNaivgationbar];
    self.topNaivgationbar.backgroundColor =[UIColor clearColor];
    
}
-(void)leftBtnAction{
//    NSString *type=self.dataModel.type;
//    if ([self.delegate respondsToSelector:@selector(inWordString:)]){
//        [self.delegate inWordString:self.wordID];
//    }
    if ([self.delegate respondsToSelector:@selector(inReasonWordAlterHb:)]){
        //XYLog(@"hb_receive=%@",self.hbModel.hb_receive);
        //XYLog(@"hb_end=%@",self.hbModel.hb_end);
        [self.delegate inReasonWordAlterHb:self.hbModel];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnAction{
    
}
#pragma mark - 红包UI
-(void)RedPacketCollectionview{
    CGFloat tableHeight=FNDeviceHeight;
    CGFloat topInterval=0;
    UICollectionViewFlowLayout* flowlayout = [UICollectionViewFlowLayout new];
    flowlayout.minimumLineSpacing = 0;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsZero;
    self.jm_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, topInterval, FNDeviceWidth, tableHeight) collectionViewLayout:flowlayout];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.dataSource = self;
    self.jm_collectionview.delegate = self;
    self.jm_collectionview.showsVerticalScrollIndicator=NO;
    self.jm_collectionview.showsHorizontalScrollIndicator=NO;
    self.jm_collectionview.hidden=YES;
    [self.view addSubview:self.jm_collectionview];
    [self.jm_collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"FNredCarryOutNaCellID"];
    [self.jm_collectionview registerClass:[FNneckBagChiefCeCell class] forCellWithReuseIdentifier:@"FNneckBagChiefCeCellID"];
    [self.jm_collectionview registerClass:[FNneckResultItemCeCell class] forCellWithReuseIdentifier:@"FNneckResultItemCeCellID"];
     [self.jm_collectionview registerClass:[FNneckTwoBagAeCell class] forCellWithReuseIdentifier:@"FNneckTwoBagAeCell"];
    
    if (@available(iOS 11.0, *)) {
        self.jm_collectionview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    self.jm_collectionview.backgroundColor=[UIColor whiteColor];
}
#pragma mark -  UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if(self.neckState==1){
        if([self.hbModel.is_own_send integerValue]==1){
            if (self.dataModel.list.count==0){
               return 1;
            }else{
               return 2;
            }
        }else{
            return 1;
        }
       
    }else{
       return 2;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    if(self.neckState==1){
//        return 1;
//    }else{
//        if (section==0) {
//           return 1;
//        }else{
//            if (self.dataModel.list.count>0) {
//                NSArray *listArr=self.dataModel.list;
//                return listArr.count;
//            }else{
//                return 0;
//            }
//        }
//    }
    if(self.neckState==1){
        if([self.hbModel.is_own_send integerValue]==1){
            if (self.dataModel.list.count==0){
                if (section==0) {
                    return 1;
                }else{
                    return 0;
                }
            }else{
                if (section==0) {
                    return 1;
                }else{
                    if (self.dataModel.list.count>0) {
                        NSArray *listArr=self.dataModel.list;
                        return listArr.count;
                    }else{
                        return 0;
                    }
                }
            }
        }else{
            return 1;
        }
    }else{
        if (section==0) {
            return 1;
        }else{
            if (self.dataModel.list.count>0) {
                NSArray *listArr=self.dataModel.list;
                return listArr.count;
            }else{
                return 0;
            }
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.neckState==1){
        if (indexPath.section==0) {
            if([self.hbModel.is_own_send integerValue]==1){
                FNneckBagChiefCeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNneckBagChiefCeCellID" forIndexPath:indexPath];
                cell.neckState=self.neckState;
                cell.model=self.dataModel;
                cell.backgroundColor =[UIColor whiteColor];
                if (self.dataModel.list.count>0) {
                   cell.hintLB.hidden=YES;
                   cell.hintLB.text=@"";
                   cell.reminderLB.text=self.dataModel.str2;
                }else{
                   cell.hintLB.hidden=NO;
                   cell.reminderLB.text=[NSString stringWithFormat:@"红包金额%@元,等待对方领取",self.dataModel.sum_money];//@"1个红包，14秒被抢光";
                   cell.hintLB.text=@"未领取的红包，将于24小时后提出退款";
                }
                
                return cell;
            }else{
                FNneckTwoBagAeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNneckTwoBagAeCell" forIndexPath:indexPath];
                cell.neckState=self.neckState;
                cell.model=self.dataModel;
                cell.backgroundColor =[UIColor whiteColor];
                cell.reminderLB.hidden=YES;
                
                return cell;
            }
        }else{
            FNneckResultItemCeCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNneckResultItemCeCellID" forIndexPath:indexPath];
            cell.backgroundColor =[UIColor whiteColor];
            if (self.dataModel.list.count>0) {
                NSArray *listArr=self.dataModel.list;
                FNopenRedPacketRecordModel *itemModel=[FNopenRedPacketRecordModel mj_objectWithKeyValues:listArr[indexPath.row]];
                cell.model=itemModel;
            }
            return cell;
        }
       
    }else{
        if (indexPath.section==0) {
            FNneckTwoBagAeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNneckTwoBagAeCell" forIndexPath:indexPath];
            cell.backgroundColor =[UIColor whiteColor];
            cell.model=self.dataModel;
            cell.neckState=self.neckState;
            if([self.dataModel.hb_type isEqualToString:@"default"]){
                cell.pinImg.image=IMAGE(@"");
            }
            if([self.dataModel.hb_type isEqualToString:@"shouqi"]){
                cell.pinImg.image=IMAGE(@"FN_hair_pinImg");
            }
            return cell;
        }else{
            FNneckResultItemCeCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FNneckResultItemCeCellID" forIndexPath:indexPath];
            cell.backgroundColor =[UIColor whiteColor];
            if (self.dataModel.list.count>0) {
                NSArray *listArr=self.dataModel.list;
                FNopenRedPacketRecordModel *itemModel=[FNopenRedPacketRecordModel mj_objectWithKeyValues:listArr[indexPath.row]];
                cell.model=itemModel;
            }
            return cell;
        }
    }
 
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat with=FNDeviceWidth;
    CGFloat height=40;
    if(self.neckState==1){
        if([self.hbModel.is_own_send integerValue]==1){
            if (self.dataModel.list.count==0){
                if (indexPath.section==0) {
                    height=FNDeviceHeight;
                }else{
                    height=0;
                }
            }else{
                if (indexPath.section==0) {
                    height=325;
                }else{
                    height=60;
                }
            }
        }else{
            height=FNDeviceHeight;
        }
    }else{
        if (indexPath.section==0) {
            height=455;
        }else{
            height=65;
        }
    }
    CGSize size = CGSizeMake(with, height);
    return size;
}
#pragma mark - //开红包
- (FNRequestTool *)apiRequestOpenRedPacket{
    @WeakObj(self);
    NSString *urlString=@"mod=appapi&act=lt_hb&ctrl=open_lthb";
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithDictionary:@{@"time":[NSString GetNowTimes],@"token":UserAccessToken}];
    if([self.hb_id kr_isNotEmpty]){
        params[@"hb_id"]=self.hb_id;
    }
    return [FNRequestTool requestWithParams:params api:urlString respondType:(ResponseTypeNone) modelType:@"" success:^(id respondsObject) {
        selfWeak.jm_collectionview.hidden=NO;
        XYLog(@"开红包结果:%@",respondsObject);
        NSDictionary *dictry=respondsObject[DataKey];
        selfWeak.dataModel=[FNopenRedPacketDeModel mj_objectWithKeyValues:dictry];
        [selfWeak.jm_collectionview reloadData];
        NSString *type=selfWeak.dataModel.type;
        
        if([selfWeak.hbModel.is_own_send integerValue]==0){
            if([selfWeak.hbModel.hb_end integerValue]==0){
               @WeakObj(self);
               [FNChatManager.shareInstance sendOpenRedEnvelopes:type withhb_id:selfWeak.hb_id toUid:selfWeak.uid withTarget:selfWeak.target];
            }
        }
    } failure:^(NSString *error) {
        XYLog(@"开红包Error:%@",error);
        [FNTipsView showTips:@"请重试!"]; 
    } isHideTips:NO isCache:NO];
}
-(void)setHbModel:(FNChatModel *)hbModel{
    _hbModel=hbModel;
}
-(void)setDataModel:(FNopenRedPacketDeModel *)dataModel{
    _dataModel=dataModel;
    if(dataModel){
       [self.jm_collectionview reloadData];
       self.jm_collectionview.hidden=NO;
    }
}
@end
