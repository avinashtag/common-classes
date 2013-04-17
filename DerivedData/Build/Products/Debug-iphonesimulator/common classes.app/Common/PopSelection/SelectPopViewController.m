//
//  SelectPopViewController.m
//  DineForaDime
//
//  Created by Vertax on 19/03/13.
//  Copyright (c) 2013 Vertax. All rights reserved.
//

#import "SelectPopViewController.h"
#import "SelectPopUpCell.h"
@interface SelectPopViewController ()
{
    NSMutableArray *CheckCell;
    UIColor *BlackColor;
    UIColor *RedColor;
}
@end

@implementation SelectPopViewController

static NSString* Yes = @"YES";
static NSString* No = @"NO";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    BlackColor = [UIColor blackColor];
    RedColor = [UIColor redColor];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)removeViewDone:(UIButton *)sender {
    [self removeWithAnimation:nil];
}

- (IBAction)closeClicked:(UIButton *)sender {
    [self removeWithAnimation:nil];
}


#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        [self.searchDisplayController.searchResultsTableView setBackgroundView:img];
        [self.searchDisplayController.searchResultsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.searchDisplayController.searchResultsTableView setFrame:_TablePopUp.frame];
    }
   
    return [_datasourceArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectPopUpCell *cell = (SelectPopUpCell *)[tableView dequeueReusableCellWithIdentifier:@"UICustomizerCellControllerIdentifier"];
    if (cell == nil)
    {
        UIViewController* myCellViewController = [[UIViewController alloc] initWithNibName:@"SelectPopUpCell" bundle:nil];
        cell = (SelectPopUpCell*)myCellViewController.view;
    }
       return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectPopUpCell *cell = (SelectPopUpCell *)[tableView cellForRowAtIndexPath:indexPath];
    if ([[CheckCell objectAtIndex:indexPath.row] isEqualToString:Yes])
    {
        [cell.Selectname setTextColor:RedColor];
        [CheckCell replaceObjectAtIndex:indexPath.row withObject:No];
    }
    else
    {
        [cell.Selectname setTextColor:BlackColor];
        [CheckCell replaceObjectAtIndex:indexPath.row withObject:Yes];
    }
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];

    if (tableView == _TablePopUp) {
        [self.popDelegate selectedItem:[_datasourceArray objectAtIndex:indexPath.row] Type:_Servicename];
//        switch (_Servicename) {
//            case SelectCategoryPop:
//                [self.popDelegate DeselectItem:[_datasourceArray objectAtIndex:indexPath.row] Type:_Servicename];
//                break;
//                
//            default:
//                break;
//        }
    }
    else
    {
        [self.popDelegate selectedItem:[_filteredListContent objectAtIndex:indexPath.row] Type:_Servicename];
    }
    if (_Servicename != SelectCategoryPop) {
        [self.Donebutton setHidden:YES];
        [self removeWithAnimation:nil];
    }
    else
    {
        [self.Donebutton setHidden:NO];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_datasourceArray removeObjectAtIndex:indexPath.row];
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    [tableView endUpdates];
}

-(void)removeWithAnimation:(UIViewController*)vc
{
    [self.view popOut:0.30 delegate:nil];
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
    return YES;
}
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString

{
    [self filterContentForSearchText:searchString scope:nil];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    //	for (ChatFollowersModel *product in _array_MyCrew)
    //	{
    //        NSComparisonResult result = [product.full_name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
    //        if (result == NSOrderedSame)
    //        {
    //            [self.filteredListContent addObject:product];
    //        }
    //	}
}


-(NSArray*)ParseForSelectedPop:(NSMutableArray*)Parsing
{
    NSMutableArray *Parsed = [[NSMutableArray alloc] init];
    
       return Parsed;
}
   

#pragma mark webservice Response
-(void)WebServiceLoadData:(id)DataModel Message:(NSString*)message
{
    
    if ([DataModel isKindOfClass:NSClassFromString(@"NSArray")])
    {
        if ([_datasourceArray count]>0) {
            [_datasourceArray removeAllObjects];
        }
        _datasourceArray = [[self ParseForSelectedPop:[DataModel mutableCopy]] mutableCopy];
                [_TablePopUp reloadData];
    }
    else if ([DataModel isKindOfClass:NSClassFromString(@"NSString")])
    {
    }
}

@end
