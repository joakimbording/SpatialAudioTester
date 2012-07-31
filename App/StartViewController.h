//
//  StartViewController.h
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface StartViewController : UIViewController <AVAudioPlayerDelegate>  {
    NSManagedObjectContext *managedObjectContext;
    AVAudioPlayer *player;    
    IBOutlet UISwitch   *arrowSwitch; 
    IBOutlet UITextField *repetitionsTextField;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet AVAudioPlayer *player;
@property (nonatomic, retain) IBOutlet UITextField *repetitionsTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil context:(NSManagedObjectContext *)managedContext;

- (IBAction)showLogFiles:(id)sender;
- (IBAction)soundTestLeft:(id)sender;
- (IBAction)soundTestRight:(id)sender;
- (IBAction)startTest:(id)sender;
- (IBAction)arrowSwitch:(id)sender;

@end
