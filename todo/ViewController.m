//
//  ViewController.m
//  todo
//
//  Created by Mr Ruby on 20/08/16.
//  Copyright © 2016 Rnjai Lamba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)addClicked:(id)sender;
@property (nonatomic) NSMutableArray *todos;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen]bounds];
    [self tableViewSetup];
    NSMutableArray *todos = [NSMutableArray arrayWithArray:@[@"First",@"Second",@"Third",@"Fourth"]];
    _todos = todos;
    [self registerNib];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)tableViewSetup{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
    
}

-(void)longPressGestureRecognized:(id)sender{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    NSLog(@"long pressed at %ld",(long)indexPath.row);
}
-(void)registerNib{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"random"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClicked:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Add a todo"
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"todo";
        textField.textColor = [UIColor darkGrayColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [self.activity startAnimating];
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        if(namefield.text.length > 0){
            [self.todos addObject:namefield.text];
            [self.tableView reloadData];
        }
        NSLog(@"%@",namefield.text);
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];}

#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.todos count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"random"];
    cell.backgroundColor = [self randomNiceColor];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel * label  = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, self.view.frame.size.width, 30)];
    label.text = [self.todos objectAtIndex:indexPath.row];
    label.textColor = [UIColor whiteColor];
    [label setFont:[UIFont boldSystemFontOfSize:20]];
    
    [cell.contentView addSubview:label];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_todos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (UIColor *)randomNiceColor
{
    CGFloat hue = (arc4random() % 360) / 359.0f;
    CGFloat saturation = (float)arc4random() / UINT32_MAX;
    CGFloat brightness = (float)arc4random() / UINT32_MAX;
    saturation = saturation < 0.5 ? 0.5 : saturation;
    brightness = brightness < 0.9 ? 0.9 : brightness;
    return [UIColor colorWithHue:hue
                      saturation:saturation
                      brightness:brightness
                           alpha:0.8];
}


@end
