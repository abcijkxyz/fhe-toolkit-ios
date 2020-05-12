/*
* IBM Confidential
*
*
* Copyright IBM Corporation 2020.
*
* The source code for this program is not published or otherwise divested of
* its trade secrets, irrespective of what has been deposited with the US
* Copyright Office.
*/

#import "CountryCapitalTableViewController.h"
#import "CapitalDetailViewController.h"


@interface CountryCapitalTableViewController ()

@property (nonatomic, copy) NSString *selectedCountry;

@end

@implementation CountryCapitalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)createData {
    self.dataSource = [[CountryData alloc] init];
    //TODO: perhaps this is where i generate the encrypter database, maybe even on a bg thread
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource.capitalArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CapitalCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.dataSource getCountry:indexPath.row];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selected = [self.dataSource getCountry:indexPath.row];
    _selectedCountry = selected;
    return indexPath;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"Capital_Detail_Segue"])
    {
        // Get reference to the destination view controller
        CapitalDetailViewController *vc = (CapitalDetailViewController *) [segue destinationViewController];
        NSLog(@"____ %@", _selectedCountry);
        vc.queryCountry = _selectedCountry;
        // Pass any objects to the view controller here, like...
        //[vc setMyObjectHere:object];
    }
}

@end