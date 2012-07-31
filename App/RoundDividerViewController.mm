//
//  RoundDividerViewController.m
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//


#import "RoundDividerViewController.h"

@implementation RoundDividerViewController

@synthesize nextRoundButton, descriptionLabel, typeLabel;

- (id)initWithTitle:(NSString *)title caption:(NSString *)caption buttonCaption:(NSString *) buttCaption typeCaption:(NSString *) typCaption {
    self = [super init];
    if (self) {
        // Custom initialization
        self.title = title;
        descriptionCaption = caption;
        buttonCaption = buttCaption;
        typeCaption = typCaption;        
        
    }
    return self;
}

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

- (void)viewDidLoad
{
    [descriptionLabel setText:descriptionCaption];
    [typeLabel setText:typeCaption];    
    [nextRoundButton  setTitle:buttonCaption forState:UIControlStateNormal];
    
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

-(void) closeWindowAfterNextRound:(NSTimer*) sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)nextRound:(id)sender 
{
    // Run [self dismissModalViewControllerAnimated:YES]; after 1 second
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(closeWindowAfterNextRound:) userInfo:nil repeats:NO];
}

- (void)dealloc {
    [nextRoundButton release];
    [super dealloc];
}

@end
