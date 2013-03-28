//
//  SelectPopViewController.h
//  DineForaDime
//
//  Created by Vertax on 19/03/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectedItem <NSObject>

@required
-(UIViewController*)selectedItem:(id)item Type:(NSInteger)type;

@optional
-(UIViewController*)DeselectItem:(id)item Type:(NSInteger)type;
@end

@interface SelectPopViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *Donebutton;
- (IBAction)removeViewDone:(UIButton *)sender;
- (IBAction)closeClicked:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *TableHeader;
@property (strong, nonatomic) IBOutlet UITableView *TablePopUp;
@property (strong, nonatomic) NSMutableArray *filteredListContent;
@property (strong, nonatomic) NSMutableArray *datasourceArray;
@property (assign, nonatomic) NSInteger Servicename;
@property (nonatomic, strong) NSMutableArray *getSelectedItem;
@property (strong, nonatomic) id<SelectedItem>popDelegate;



typedef enum 
{
    selectStore= 0,
    couponType,
    SelectCategoryPop,
}servicePop;


@end
