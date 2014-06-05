//
//  TipViewController.m
//  TipCalculator
//
//  Created by Alex on 6/3/14.
//  Copyright (c) 2014 alexnj. All rights reserved.
//

#import "TipViewController.h"
#import "SettingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipPercentControl;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property NSInteger cachedTipPreference;
@property NSUserDefaults *preferences;
@property NSNumberFormatter *numberFormatter;
@end

@implementation TipViewController

- (IBAction)billAmountChanged:(UITextField *)sender {
    [self UpdateTip];
}

- (IBAction)tipRateChanged:(UISegmentedControl *)sender {
    [self UpdateTip];
}

- (IBAction)tappedBlankArea:(UITapGestureRecognizer *)sender {
    [[self view] endEditing:YES];
}

- (void)UpdateTip
{
    float amount, percent, tip, total;
    
    amount  = self.billAmountField.text.floatValue;
    percent = .10 + .05 * [self.tipPercentControl selectedSegmentIndex];
    tip     = amount * percent;
    total   = amount + tip;
    
    self.tipAmountLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat: tip]];
    self.totalLabel.text = [self.numberFormatter stringFromNumber:[NSNumber numberWithFloat: total]];
}

- (void)onSettingsButton
{
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadDefaults
{
    int storedSetting = [self.preferences integerForKey:@"default_tip"];
    if (storedSetting != self.cachedTipPreference) {
        self.cachedTipPreference = storedSetting;
        [self.tipPercentControl setSelectedSegmentIndex:self.cachedTipPreference];
        [self UpdateTip];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.preferences = [NSUserDefaults standardUserDefaults];

    // Get right currency styles for user locale.
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [self.numberFormatter setLocale:[NSLocale currentLocale]];
    
    [self.billAmountField setKeyboardType:UIKeyboardTypeDecimalPad];
    [self.billAmountField becomeFirstResponder];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    self.title = @"Tip Calculator";
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
