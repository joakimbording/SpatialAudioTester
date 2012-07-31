//
//  TestDataViewController.m
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import "TestDataViewController.h"
#import "TestData.h"

@implementation TestDataViewController

@synthesize testDataArray;
@synthesize managedObjectContext;
@synthesize exportButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Test Log";
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    exportButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(exportButtonTouched:)];
    exportButton.enabled = YES;
    self.navigationItem.rightBarButtonItem = exportButton;
    
    // Fetch data
    testDataArray = [[NSMutableArray alloc] init];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TestData" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    //Sort data (sorter etter flere ved å putte i array)
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"userNum" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptors];
    [sortDescriptors release];
    [sortDescriptor release];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"Yo! Error in fetching data");
    }
    
    [self setTestDataArray:mutableFetchResults];
    [mutableFetchResults release];
    [request release];
}


- (void)viewDidUnload
{
    self.testDataArray = nil;
    self.exportButton = nil;
    
    [super viewDidUnload];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{ 
    if(buttonIndex == 1){ // If export is pressed and not cancel
    NSLog(@"Entered: %@",[[alertView textFieldAtIndex:0] text]);
        
        NSDate* date = [NSDate date];
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"MM-dd_hh-mm_"];
        NSString* dateStr = [formatter stringFromDate:date];
        NSString* filenam = [NSString stringWithFormat:@"%@%@.sqlite", dateStr, [[alertView textFieldAtIndex:0] text]];
        NSError *error = nil;
        NSArray *thePathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        [[NSFileManager defaultManager] copyItemAtPath:[[thePathArray objectAtIndex:0] stringByAppendingPathComponent: @"TestData.sqlite"] toPath:[[thePathArray objectAtIndex:0] stringByAppendingPathComponent:filenam] error:&error];
        NSLog(@"%@", [error localizedDescription]);

         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Testdata Exportert" message:filenam delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
         [alert show];
         [alert release];
    }
}

- (IBAction)exportButtonTouched:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eksporter TestData" message:@"Spesifiser filnavn" delegate:self cancelButtonTitle:@"Avbryt" otherButtonTitles:@"Eksporter", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    [alert release];
    
    
     NSLog(@"Exporting!");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [testDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    // Dequeue or create a new cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    TestData *testData = (TestData *)[testDataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"User: %i Round: %i Aim: %i", [[testData userNum] integerValue], [[testData setupRound] integerValue], [[testData aimNum] integerValue] ]; 
    
    NSString *string = [NSString stringWithFormat:@"%@ Off: %.1f Ang: %.1f Sec: %.1f", [testData setupType], [[testData beaconOffset] floatValue], [[testData beaconStartOffset] floatValue], [[testData timeSinceLast] floatValue]];
    cell.detailTextLabel.text = string;
    
    return cell;

}


- (NSString*) returnTestSummaryFromUserNum:(int)userNum
{
    return @"test";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TestData *testData = (TestData *) [testDataArray objectAtIndex:[indexPath row]];
    

    NSString *msg = [[NSString alloc] initWithFormat:[self returnTestSummaryFromUserNum:[[testData userNum] integerValue]]]; // Viser hele innholdet i objektet
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test Oppsummering" message:msg delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil];
    [alert show];
    [alert release];
    [msg release]; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [managedObjectContext release];
    [testDataArray release];
    [exportButton release];
    [super dealloc];
}

@end
