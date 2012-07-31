//
//  StartViewController.m
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import "StartViewController.h"
#import "BeaconViewController.h"
#import "TestDataViewController.h"

@implementation StartViewController

@synthesize managedObjectContext;
@synthesize player;
@synthesize repetitionsTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)managedContext
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.managedObjectContext = managedContext;
        
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                                      target:self 
                                      action:@selector(showLogFiles:)];

        [[self navigationItem] setRightBarButtonItem:addButton];
        [addButton release];
        
        self.title = NSLocalizedString(@"Audio Beacon", @"Audio Beacon");
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

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    // Set title on the backbutton
    UIBarButtonItem * tempButtonItem = [[[ UIBarButtonItem alloc] init] autorelease];
    tempButtonItem .title = @"Back";
    self.navigationItem.backBarButtonItem = tempButtonItem ;
    
    [self setPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"AppleGlass" ofType:@"aiff"]] error:nil]];
    [player prepareToPlay];    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showLogFiles:(id)sender
{
    NSLog(@"Logfiles"); 
    
    TestDataViewController *viewController = [[TestDataViewController alloc] initWithStyle:UITableViewStylePlain];
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        // Handle the error.
    }
    // Pass the managed object context to the view controller.
    viewController.managedObjectContext = context;
    [self.navigationController pushViewController:viewController animated:YES];  
    [viewController release];
    
}

- (IBAction)soundTestLeft:(id)sender
{
    NSLog(@"Venstre"); 
    if(![player isPlaying]) [player play];
}

- (IBAction)soundTestRight:(id)sender
{
    NSLog(@"Høyre");  
    //[self playSoundFile:@"/TickPiano5656A.aiff"];    

}

- (IBAction)startTest:(id)sender
{
    NSLog(@"Start Test");
    BeaconViewController *viewController = [[BeaconViewController alloc] initWithNibName:@"BeaconViewController" bundle:nil context:self.managedObjectContext];
    if(arrowSwitch.on) viewController.showArrow = YES;
    else viewController.showArrow = NO;
    viewController.repetitions = [NSNumber numberWithInt:[repetitionsTextField.text intValue]];    
    [self.navigationController pushViewController:viewController animated:YES];  
    [viewController release];
    
}

- (IBAction)arrowSwitch:(id)sender {
    //
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
