//
//  BBTestViewController.m
//  bbuievo
//
//  Created by bumbieris on 26/03/2013.
//  Copyright (c) 2013 bumbieris. All rights reserved.
//

#import "BBTestViewController.h"
#import "BBHyperLabel.h"
#import "BBSpinButton.h"

@interface BBTestViewController ()
@property (nonatomic, strong) IBOutlet BBHyperLabel* label;
@property (nonatomic, strong) IBOutlet BBHyperLabel* labelNoUnderline;
@property (nonatomic, strong) IBOutlet BBSpinButton* spinButton;
- (IBAction)spinButtonPressed:(id)sender;
@end

@implementation BBTestViewController

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
	// Do any additional setup after loading the view.
    _label.target = self;
    _label.action = @selector(linkClicked:);
    _labelNoUnderline.target = self;
    _labelNoUnderline.action = @selector(linkClicked:);
    _labelNoUnderline.underline = FALSE;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_label deselect];
    [_labelNoUnderline deselect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) linkClicked: (id) a
{
    if ([self.navigationItem.title isEqualToString:@"Foo"]){
        [self performSegueWithIdentifier:@"Foo" sender:self];
    }else
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)spinButtonPressed:(id)sender
{
    if (![_spinButton active])
        [_spinButton showSpinner];
    else
        [_spinButton hideSpinner];
}

- (void) foo
{
    
}

@end
