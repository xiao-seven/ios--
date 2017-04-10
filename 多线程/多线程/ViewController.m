//
//  ViewController.m
//  多线程
//
//  Created by Aseven on 2017/3/8.
//  Copyright © 2017年 Aseven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(retain)NSMutableArray* urlArr;
@property(retain)NSMutableArray* threaadArr;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSString* urlString1=@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488945902331&di=7fdd1b3d0c092ad0f299280e206b4276&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201510%2F10%2F20151010192906_YyCMV.jpeg";
    NSString* urlString2=@"http://img3.imgtn.bdimg.com/it/u=2014354998,2027415039&fm=23&gp=0.jpg";
    NSString* urlString3=@"http://img3.imgtn.bdimg.com/it/u=3866347434,2727747175&fm=23&gp=0.jpg";
    NSString* urlString4=@"http://4493bz.1985t.com/uploads/allimg/160618/5-16061Q50350.jpg";
    _urlArr=[[NSMutableArray alloc]init];
    [_urlArr addObject:urlString1];
    [_urlArr addObject:urlString2];
    [_urlArr addObject:urlString3];
    [_urlArr addObject:urlString4];
    _threaadArr=[[NSMutableArray alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)xiazai:(UIButton *)sender {
    for (int i=0; i<4; i++) {
        //第一个参数是响应方法，即选择器
        //第二个参数是响应者
        //第三个参数是所携带的参数，参数类型是id类型也就是对象类型
        NSArray* arr=@[_urlArr[i],[NSString stringWithFormat:@"%d",i+1]];
        NSThread* thread=[[NSThread alloc]initWithTarget:self selector:@selector(downloadImage:) object:arr];
        [_threaadArr addObject:thread];
        //开启线程
        [thread start];
    }
}

-(void)downloadImage:(NSArray*)arr
{
    NSLog(@"%@",arr);
    //让线程沉睡5秒钟
    
    NSURL* url=[NSURL URLWithString:arr[0]];
    NSData* data=[NSData dataWithContentsOfURL:url];
    UIImage* image=[UIImage imageWithData:data];
    UIImageView *imageView11=(UIImageView*)[self.view viewWithTag:[arr[1] intValue]];
    imageView11.image=image;
}





- (IBAction)quxiaoxiazai:(UIButton *)sender {
    for (NSThread* thread in _threaadArr) {
        //取消线程
        [thread cancel];
    }
}


@end
