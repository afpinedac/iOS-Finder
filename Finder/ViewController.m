//
//  ViewController.m
//  Finder
//
//  Created by Andres Pineda on 5/11/16.
//  Copyright © 2016 AP. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController (){
        NSManagedObjectContext *context;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //add who is going to listen to this field
    [[self firstnameTextField]setDelegate:self];
    [[self lastnameTextField]setDelegate:self];
    
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    context = [appDelegate managedObjectContext];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPersonButton:(id)sender {
    
    NSEntityDescription *entDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSManagedObject *newPerson =[[NSManagedObject alloc]initWithEntity:entDescription insertIntoManagedObjectContext:context];
    
    [newPerson setValue:self.firstnameTextField.text forKey:@"firstname"];
    [newPerson setValue:self.lastnameTextField.text forKey:@"lastname"];
    
    NSError *error;
    
    [context save:&error];
    self.displayLabel.text = @"Person added";
    
}

- (IBAction)searchButton:(id)sender {
    
    NSEntityDescription *entDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSPredicate *predicate  = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@", self.firstnameTextField.text,self.lastnameTextField.text];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    [request setEntity:entDescription];
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    if(matchingData.count <= 0){
        self.displayLabel.text = @"No records found";
    }else{
        NSString *firstName;
        NSString *lastName;
        
        for (NSManagedObject *obj in matchingData) {
            firstName = [obj valueForKey:@"firstname"];
            lastName = [obj valueForKey:@"lastname"];
        }
        self.displayLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    }
    
}
- (IBAction)deleteButton:(id)sender {
    
    NSEntityDescription *entDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"firstname like %@ and lastname like %@", self.firstnameTextField.text, self.lastnameTextField.text];
    
    [request setEntity:entDescription];
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    int count = 0;
    if(matchingData.count == 0){
      self.displayLabel.text = @"No person deleted";
    }else{
        for(NSManagedObject * obj in matchingData){
            count++;
            [context deleteObject:obj];
        }
        
        self.displayLabel.text=[NSString stringWithFormat:@"%d persons deleted", count ];
    }
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
