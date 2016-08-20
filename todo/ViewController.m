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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [[UIScreen mainScreen]bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    NSMutableArray *todos = [NSMutableArray arrayWithArray:@[@"First",@"Second"]];
    _todos = todos;
    [self registerNib];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)registerNib{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"random"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addClicked:(id)sender {

}

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
    cell.backgroundColor = [UIColor blackColor];
//    cell.frame = CGRectMake(0, 62 + indexPath.row*200, self.view.frame.size.width, 200);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


@end
