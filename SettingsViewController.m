//
//  SettingsViewController.m
//  TipCalculator
//
//  Created by Alex J. on 6/4/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property NSUserDefaults *defaults;
@end

@implementation SettingsViewController

- (IBAction)onDefaultTipChanged:(UISegmentedControl *)sender {
    [self saveData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)loadData {
    [self.defaultTipControl setSelectedSegmentIndex:[self.defaults integerForKey:@"default_tip"]];
    
    NSLog(@"Default tip: %i",[self.defaults integerForKey:@"default_tip"]);
    
}

- (void)saveData {
    [self.defaults setInteger:[self.defaultTipControl selectedSegmentIndex] forKey:@"default_tip"];
    [self.defaults synchronize];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
