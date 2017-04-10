#import "RootViewController.h"
#import "MyCell.h"
#import "SuppleView.h"

@interface RootViewController ()
{
    
    //集合视图，iOS6之后出现的视图控件,与UITableView相比，它能够更加灵活的设置cell的布局
    UICollectionView *_collectionView;
}

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //UICollectionViewLayout->集合视图用于布局item的布局类
    //UICollectionViewFlowLayout->能够对集合视图中的item进行网格布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //设置网格布局方向(垂直)
    //[layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    [layOut setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    layOut.minimumLineSpacing =3;//纵向的最小间隔 (可以直接调节)
    layOut.minimumInteritemSpacing = 0; //横向的最小间隔(结合UIEageInsets调节)
    //初始化集合视图，传入布局对象
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,64,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layOut];
    //设置数据源和代理
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //利用集合视图，提前注册xib(或者提前注册cell)
    //[_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    //注册header和footer
    //注册header 并设置重用标识符
    [_collectionView registerClass:[SuppleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Supple"];
    [_collectionView registerClass:[SuppleView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Supple"];
    [self.view addSubview:_collectionView];
    
	// Do any additional setup after loading the view.
}

#pragma mark - UICollectionViewDelegate
//选中某一个item后，触发的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select section:%d item:%d",indexPath.section,indexPath.item);
    
}

#pragma mark - UICollectionViewDataSource
//集合视图有多少个分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde = @"Cell";
    //collectionView 会自动创建cell，或者自动从重用队列中取cell
    //indexPath.item
    MyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIde forIndexPath:indexPath];
    //直接赋值
    cell.headImageView.image = [UIImage imageNamed:@"0.png"];
    cell.nameLabel.text = @"test";
    return cell;
}

//collectionView对header和footer会自动创建,我们需要对header和footer赋不同的值
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString *viewIde = @"Supple";
    //从重用队列中取header和footerview 取不到会自动创建
    SuppleView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewIde forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view.backgroundColor = [UIColor yellowColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        view.backgroundColor = [UIColor blueColor];

    }
    return view;

    
    
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //每个item也可以调成不同的大小
    return CGSizeMake(150,120);
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10,7, 10, 7);
}

//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0,20);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
     return CGSizeMake(0,20);
}

@end
