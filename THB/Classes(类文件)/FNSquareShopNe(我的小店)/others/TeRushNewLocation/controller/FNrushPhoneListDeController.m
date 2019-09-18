//
//  FNrushPhoneListDeController.m
//  69橙子
//
//  Created by 李显 on 2018/12/9.
//  Copyright © 2018 方诺科技. All rights reserved.
//

#import "FNrushPhoneListDeController.h"
#import "LJPerson.h"
#import "LJContactManager.h"
#import "FNrushPhoneDeCell.h"
@interface FNrushPhoneListDeController ()
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, copy) NSArray *keys;
@end

@implementation FNrushPhoneListDeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择联系人";
    [[LJContactManager sharedInstance] accessSectionContactsComplection:^(BOOL succeed, NSArray<LJSectionPerson *> *contacts, NSArray<NSString *> *keys) {
        
        self.dataSource = contacts;
        self.keys = keys;
        [self.tableView reloadData];
        
        for (LJSectionPerson *sectionModel in contacts)
        {
            NSLog(@"---------------------***%@***------------------------------------",sectionModel.key);
            
            for (LJPerson *person in sectionModel.persons)
            {
                NSLog(@"名字列表：fullName = %@, firstName = %@, lastName = %@", person.fullName, person.familyName, person.givenName);
                
                for (LJPhone *model in person.phones)
                {
                    NSLog(@"号码：phone = %@, label = %@", model.phone,model.label);
                }
                
                for (LJEmail *model in person.emails)
                {
                    NSLog(@"电子邮件：email = %@, label = %@", model.email, model.label);
                }
                
                for (LJAddress *model in person.addresses)
                {
                    NSLog(@"地址：address = %@, label = %@", model.city, model.label);
                }
                for (LJMessage *model in person.messages)
                {
                    NSLog(@"即时通讯：service = %@, userName = %@", model.service, model.userName);
                }
                
                NSLog(@"生日：brithdayDate = %@",person.birthday.brithdayDate);
                
                for (LJSocialProfile *model in person.socials)
                {
                    NSLog(@"社交：service = %@, username = %@, urlString = %@", model.service, model.username, model.urlString);
                }
                
                for (LJContactRelation *model in person.relations)
                {
                    NSLog(@"关联人：label = %@, name = %@", model.label, model.name);
                }
                
                for (LJUrlAddress *model in person.urls)
                {
                    NSLog(@"URL：label = %@, urlString = %@", model.label,model.urlString);
                }
                
            }
        }
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 
  return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LJSectionPerson *sectionModel = self.dataSource[section];
    return sectionModel.persons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    FNrushPhoneDeCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FNrushPhoneDeCellID"];
    if (cell == nil) {
        cell = [[FNrushPhoneDeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FNrushPhoneDeCellID"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LJSectionPerson *sectionModel = self.dataSource[indexPath.section];
    LJPerson *personModel = sectionModel.persons[indexPath.row];
    cell.model = personModel;
   
    return cell;
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    LJSectionPerson *sectionModel = self.dataSource[section];
    return sectionModel.key;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LJSectionPerson *sectionModel = self.dataSource[indexPath.section];
    LJPerson *personModel = sectionModel.persons[indexPath.row];
    LJPhone *phoneModel = personModel.phones.firstObject; 
    if ([self.delegate respondsToSelector:@selector(inSelectPhoneAction:)]) {
        [self.delegate inSelectPhoneAction:phoneModel.phone];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)dealloc
{
    NSLog(@"dealloc");
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
