//
//  RoundDividerViewController.h
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <UIKit/UIKit.h>

@interface RoundDividerViewController : UIViewController {
    UIButton *nextRoundButton;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *typeLabel;    
    NSString *descriptionCaption;
    NSString *buttonCaption;
    NSString *typeCaption;    
}

@property (nonatomic, retain) IBOutlet UIButton *nextRoundButton;
@property (nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, retain) IBOutlet UILabel *typeLabel;

- (id)initWithTitle:(NSString *)title caption:(NSString *)caption buttonCaption:(NSString *) buttCaption typeCaption:(NSString *) typCaption;

- (IBAction)nextRound:(id)sender;


@end
