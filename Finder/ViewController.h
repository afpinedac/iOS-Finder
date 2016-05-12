//
//  ViewController.h
//  Finder
//
//  Created by Andres Pineda on 5/11/16.
//  Copyright © 2016 AP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *firstnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastnameTextField;
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;


- (IBAction)addPersonButton:(id)sender;
- (IBAction)searchButton:(id)sender;
- (IBAction)deleteButton:(id)sender;


@end
