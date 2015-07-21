//
//  ViewController.m
//  Calculator
//
//  Created by TRM on 7/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic)UILabel *displayLabel;
@property (strong, nonatomic)UIButton *numButton0;
@property (strong, nonatomic)UIButton *numButton1;
@property (strong, nonatomic)UIButton *numButton2;
@property (strong, nonatomic)UIButton *numButton3;
@property (strong, nonatomic)UIButton *numButton4;
@property (strong, nonatomic)UIButton *numButton5;
@property (strong, nonatomic)UIButton *numButton6;
@property (strong, nonatomic)UIButton *numButton7;
@property (strong, nonatomic)UIButton *numButton8;
@property (strong, nonatomic)UIButton *numButton9;
@property (strong, nonatomic)UIButton *opButtonPlus;
@property (strong, nonatomic)UIButton *opButtonMinus;
@property (strong, nonatomic)UIButton *opButtonMultiply;
@property (strong, nonatomic)UIButton *opButtonDivide;
@property (strong, nonatomic)UIButton *opButtonEnter;
@property (strong, nonatomic)UIColor *originalColor;
@property         (nonatomic)BOOL isInTheMiddleOfTypingNumber;
@property         (nonatomic)double displayValue;
@property (strong, nonatomic)NSMutableArray *operandStackArray;

@end

@implementation ViewController

#pragma mark - View Did Load

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.originalColor = [UIColor whiteColor];
    
    self.operandStackArray = [NSMutableArray new];
    
    self.title = @"RPN Calculator";
    
    UIColor *lightBlueColor = [UIColor colorWithRed:130/255.0f green:163/255.0f blue:255/255.0f alpha:1.0f];
    self.view.backgroundColor = lightBlueColor;
    
    id topLayoutGuide = self.topLayoutGuide;
    
#pragma mark - View Did Load - Display Label
    
    self.displayLabel = [UILabel new];
    UIColor *lightBlueGrayColor = [UIColor colorWithRed:165/255.0f green:177/255.0f blue:211/255.0f alpha:1.0f];
    self.displayLabel.backgroundColor = lightBlueGrayColor;
    self.displayLabel.font = [UIFont fontWithName:@"Helvetica" size:32.0];
    self.displayLabel.textAlignment = NSTextAlignmentRight;
    self.displayLabel.text = @"0";
    
    [self.displayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.displayLabel];
    
#pragma mark - View Did Load - Buttons
    
    self.numButton0 = [UIButton new];
    self.numButton1 = [UIButton new];
    self.numButton2 = [UIButton new];
    self.numButton3 = [UIButton new];
    self.numButton4 = [UIButton new];
    self.numButton5 = [UIButton new];
    self.numButton6 = [UIButton new];
    self.numButton7 = [UIButton new];
    self.numButton8 = [UIButton new];
    self.numButton9 = [UIButton new];
    self.opButtonPlus = [UIButton new];
    self.opButtonMinus = [UIButton new];
    self.opButtonMultiply = [UIButton new];
    self.opButtonDivide = [UIButton new];
    self.opButtonEnter = [UIButton new];
    
    NSArray *buttonArray = @[self.numButton0, self.numButton1, self.numButton2, self.numButton3, self.numButton4, self.numButton5, self.numButton6, self.numButton7, self.numButton8, self.numButton9, self.opButtonPlus, self.opButtonMinus, self.opButtonMultiply, self.opButtonDivide, self.opButtonEnter];
    
    [self setButtonsForButtonArray:buttonArray];
    
#pragma mark - View Did Load - Constraints
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(topLayoutGuide, _displayLabel, _numButton0, _numButton1, _numButton2, _numButton3, _numButton4, _numButton5, _numButton6, _numButton7, _numButton8, _numButton9, _opButtonPlus, _opButtonMinus, _opButtonMultiply, _opButtonDivide, _opButtonEnter);
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(5.0)-[_displayLabel]-(5.0)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10.0)-[_numButton7]-(10.0)-[_numButton8(==_numButton7)]-(10.0)-[_numButton9(==_numButton7)]-(10.0)-[_opButtonPlus(==_numButton7)]-(10.0)-|"
                                                          options:NSLayoutFormatAlignAllCenterY
                                                          metrics:nil
                                                            views:viewsDictionary];
    
    [self.view addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10.0)-[_numButton4]-(10.0)-[_numButton5(==_numButton7)]-(10.0)-[_numButton6(==_numButton7)]-(10.0)-[_opButtonMinus(==_numButton7)]-(10.0)-|"
                                                          options:NSLayoutFormatAlignAllCenterY
                                                          metrics:nil
                                                            views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10.0)-[_numButton1]-(10.0)-[_numButton2(==_numButton7)]-(10.0)-[_numButton3(==_numButton7)]-(10.0)-[_opButtonMultiply(==_numButton7)]-(10.0)-|"
                                                          options:NSLayoutFormatAlignAllCenterY
                                                          metrics:nil
                                                            views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(10.0)-[_numButton0(==_numButton7)]-(10.0)-[_opButtonEnter]-(10.0)-[_opButtonDivide(==_numButton7)]-(10.0)-|"
                                                          options:NSLayoutFormatAlignAllCenterY
                                                          metrics:nil
                                                            views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topLayoutGuide]-[_displayLabel(50.0)]-(10.0)-[_numButton7]-(10.0)-[_numButton4(==_numButton7)]-(10.0)-[_numButton1(==_numButton7)]-(10.0)-[_numButton0(==_numButton7)]-(10.0)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:viewsDictionary];
    
    [self.view addConstraints:constraints];
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.numButton8
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.numButton7
                                                                  attribute:NSLayoutAttributeHeight
                                                                 multiplier:1.0
                                                                   constant:0.0];
    
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:self.numButton9
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.opButtonPlus
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.numButton5
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.numButton6
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.opButtonMinus
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.numButton2
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.numButton3
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.opButtonMultiply
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.opButtonEnter
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.opButtonDivide
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.numButton7
                                              attribute:NSLayoutAttributeHeight
                                             multiplier:1.0
                                               constant:0.0];
    
    [self.view addConstraint:constraint];

}

#pragma mark - 'Set Buttons' Method

- (void)setButtonsForButtonArray:(NSArray *)buttonArray {
    
    for (int i = 0; i < 15; i++) {
        UIButton *button = buttonArray[i];
        if (i < 10) {
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        } else {
            [button setBackgroundColor:[UIColor lightGrayColor]];
        }
        if (i == 10) {
            [button setTitle:@"+" forState:UIControlStateNormal];
            [self operatorButtonPressed:button];
        } else if (i == 11) {
            [button setTitle:@"-" forState:UIControlStateNormal];
            [self operatorButtonPressed:button];
        } else if (i == 12) {
            [button setTitle:@"x" forState:UIControlStateNormal];
            [self operatorButtonPressed:button];
        } else if (i == 13) {
            [button setTitle:@"/" forState:UIControlStateNormal];
            [self operatorButtonPressed:button];
        } else if (i == 14) {
            [button setTitle:@"Enter" forState:UIControlStateNormal];
            [self enterButtonPressed:button];
        } else {
            [button setTitle:[NSString stringWithFormat:@"%i", i] forState:UIControlStateNormal];
            [self numButtonPressed:button];
        }
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addSubview:button];
    }
}

#pragma mark - 'Appending a Digit' Method

- (void)appendDigitFromButton:(UIButton *)sender {
    
    if (self.isInTheMiddleOfTypingNumber) {
        NSString *newDisplayText = [NSString stringWithFormat:@"%@%@", self.displayLabel.text, sender.currentTitle];
        self.displayLabel.text = newDisplayText;
    } else {
        self.displayLabel.text = sender.currentTitle;
        self.isInTheMiddleOfTypingNumber = YES;
    }
    
    if ([self.displayLabel.text length] > 20) {
        // User cannot type more than 20 characters
        self.displayLabel.text = [self.displayLabel.text substringToIndex:20];
    }
}

#pragma mark - 'Operator' Method

- (void)operate:(UIButton *)sender {
    
    if (self.isInTheMiddleOfTypingNumber) {
        [self enter];
    }
    
    if ([self.operandStackArray count] >= 2) {
        NSNumber *lastNumber = [self popOperandStack];
        NSNumber *penultimateNumber = [self popOperandStack];
        NSString *operator = sender.currentTitle;
        if ([operator isEqualToString:@"+"]) {
            [self setDisplayValue:([penultimateNumber doubleValue] + [lastNumber doubleValue])];
        } else if ([operator isEqualToString:@"-"]) {
            [self setDisplayValue:([penultimateNumber doubleValue] - [lastNumber doubleValue])];
        } else if ([operator isEqualToString:@"x"]) {
            [self setDisplayValue:([penultimateNumber doubleValue] * [lastNumber doubleValue])];
        } else if ([operator isEqualToString:@"/"]) {
            [self setDisplayValue:([penultimateNumber doubleValue] / [lastNumber doubleValue])];
        }
        [self enter];
    }
}

#pragma mark - 'Enter' Method

- (void)enter {
    
    self.isInTheMiddleOfTypingNumber = NO;
    NSNumber *nsNumDisplayValue = [NSNumber numberWithDouble:[self displayValue]];
    [self.operandStackArray addObject:nsNumDisplayValue];
    NSLog(@"%@", self.operandStackArray);
}

#pragma mark - 'Pop Operand Stack' Method

- (NSNumber *)popOperandStack {
    
    NSNumber *lastNumber = self.operandStackArray[([self.operandStackArray count]-1)];
    [self.operandStackArray removeObjectAtIndex:([self.operandStackArray count]-1)];
    return lastNumber;
}

#pragma mark - 'Change Color' Methods

- (void)changeColorWhilePressed:(UIButton *)sender {
    
    self.originalColor = sender.backgroundColor;
    [sender setBackgroundColor:[UIColor purpleColor]];
}

- (void)changeColorBack:(UIButton *)sender {
    
    [sender setBackgroundColor:self.originalColor];
}

#pragma mark - Target Actions

- (IBAction)numButtonPressed:(id)sender {
    
    [sender addTarget:self action:@selector(changeColorWhilePressed:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(changeColorBack:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(appendDigitFromButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)enterButtonPressed:(id)sender {
    
    [sender addTarget:self action:@selector(changeColorWhilePressed:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(changeColorBack:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)operatorButtonPressed:(id)sender {
    
    [sender addTarget:self action:@selector(changeColorWhilePressed:) forControlEvents:UIControlEventTouchDown];
    [sender addTarget:self action:@selector(changeColorBack:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(operate:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Display Value getter and setter

- (double)displayValue {
    
    return [self.displayLabel.text doubleValue];
}

- (void)setDisplayValue:(double)displayValue {
    
    self.displayLabel.text = [NSString stringWithFormat:@"%f", displayValue];
    
    if ([self.displayLabel.text length] > 20) {
        // User cannot type more than 20 characters
        self.displayLabel.text = [self.displayLabel.text substringToIndex:20];
    }
    
    self.isInTheMiddleOfTypingNumber = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
