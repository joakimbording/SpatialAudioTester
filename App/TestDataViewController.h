//
//  TestDataViewController.h
//  AudioCompass
//
//  Created by Joakim Bording on 17.02.12 - joakim@bording.no - joakim.bording.no
//  This work is shared under the creative common license: Attribution-NonCommercial ShareAlike 3.0 Unported 
//  http://creativecommons.org/licenses/by-nc-sa/3.0/
//
//  Author should always be credited 
//

#import <UIKit/UIKit.h>

@interface TestDataViewController : UITableViewController {
    NSMutableArray *testDataArray;
    NSManagedObjectContext *managedObjectContext;
    UIBarButtonItem *exportButton;    
}

@property (nonatomic, retain) NSMutableArray *testDataArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) UIBarButtonItem *exportButton;

- (IBAction)exportButtonTouched:(id)sender;

@end
