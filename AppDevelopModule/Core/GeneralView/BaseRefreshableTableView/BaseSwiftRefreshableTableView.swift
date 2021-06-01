////
////  BaseSwiftRefreshableTableView.swift
////  yunchaodan
////
////  Created by 王立 on 2021/6/1.
////  Copyright © 2021 https://www.clouderwork.com. All rights reserved.
////
//
//import UIKit
//import MJRefresh
//import Moya
//import RxSwift
//
//class BaseSwiftRefreshableTableView: UITableView {
//    typealias PageIndex = Int
//    typealias PageSize = Int
//    typealias RefreshActBlock = (_ pageIndex:PageIndex,_ pageSize:PageSize)->Single<Response>?
//    typealias GetRefreshDataBlock<M:HandyJSON> = (M)->Int
//    private var originalPageIndex = 1
//    var pageIndex = 1
//    private var pageSize = 10
//    private var disBag = DisposeBag.init()
//    
//    // MARK: 生命周期
//    override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    func enableRefresh<T:HandyJSON>(requestAct:@escaping RefreshActBlock,mapModelType : T.Type,mapPath:String = "",refreshData: @escaping GetRefreshDataBlock<T>,loadMoreData: @escaping GetRefreshDataBlock<T>,originalPageIndex:Int,pageSize:Int,emptyView:UIView?,emptyOffsetY:CGFloat = 0){
//        self.originalPageIndex = originalPageIndex
//        self.pageIndex = originalPageIndex
//        self.pageSize = pageSize
//        self.nd_empty = emptyView;
//        self.emptyOffsetY = emptyOffsetY
//        if self.nd_empty != nil {
//            self.nd_ShowEmpty()
//        }
//        
//        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
//            guard let strongSelf = self else {return}
////            if strongSelf.mj_footer!.isRefreshing{
////                strongSelf.mj_header!.endRefreshing()
////                return
////            }
//            strongSelf.pageIndex = strongSelf.originalPageIndex
//            requestAct(strongSelf.pageIndex, strongSelf.pageSize)?.mapCode().asObservable().mapModel(mapModelType, atKeyPath: mapPath).subscribe(onNext: { model in
//                let getDataCount = refreshData(model)
//                if getDataCount < strongSelf.pageSize{
//                    strongSelf.mj_footer?.endRefreshingWithNoMoreData()
//                } else {
//                    strongSelf.mj_footer?.resetNoMoreData()
//                }
//                strongSelf.mj_header?.endRefreshing()
//                strongSelf.mj_footer?.isHidden = (getDataCount == 0)
//                if strongSelf.nd_empty != nil {
//                    getDataCount > 0 ? strongSelf.nd_hideEmpty() : strongSelf.nd_ShowEmpty()
//                }
//                strongSelf.reloadData()
//            }, onError: { error in
//                HUDToast(error.description)
//                strongSelf.mj_header?.endRefreshing()
//                strongSelf.mj_footer?.endRefreshing()
//            }).disposed(by: strongSelf.disBag)
//        })
//        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {[weak self] in
//            guard let strongSelf = self else {return}
////            if strongSelf.mj_header!.isRefreshing{
////                strongSelf.mj_footer!.endRefreshing()
////                return
////            }
//            strongSelf.pageIndex += 1
//            requestAct(strongSelf.pageIndex, strongSelf.pageSize)?.mapCode().asObservable().mapModel(mapModelType, atKeyPath: mapPath).subscribe(onNext: { model in
//                let getDataCount = loadMoreData(model)
//                if getDataCount < strongSelf.pageSize{
//                    strongSelf.mj_footer?.endRefreshingWithNoMoreData()
//                }else{
//                    strongSelf.mj_footer?.endRefreshing()
//                }
//                strongSelf.reloadData()
//            }, onError: { error in
//                HUDToast(error.description)
//                strongSelf.mj_header?.endRefreshing()
//                strongSelf.mj_footer?.endRefreshing()
//            }).disposed(by: strongSelf.disBag)
//        })
//        self.mj_footer?.isHidden = true
//    }
//    
//    
//    func addRefreshHeader<T:HandyJSON>(requestAct:@escaping RefreshActBlock,modelType : T.Type,mapPath:String = "",refreshData: @escaping GetRefreshDataBlock<T>,emptyView:UIView?,emptyOffsetY:CGFloat = 0){
//        self.nd_empty = emptyView;
//        self.emptyOffsetY = emptyOffsetY
//        if self.nd_empty != nil {
//            self.nd_ShowEmpty()
//        }
//        
//        self.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
//            guard let strongSelf = self else {return}
//            requestAct(strongSelf.pageIndex, strongSelf.pageSize)?.mapCode().asObservable().mapModel(modelType, atKeyPath: mapPath).subscribe(onNext: { model in
//                let getDataCount = refreshData(model)
//                strongSelf.mj_header?.endRefreshing()
//                if strongSelf.nd_empty != nil {
//                    getDataCount > 0 ? strongSelf.nd_hideEmpty() : strongSelf.nd_ShowEmpty()
//                }
//                strongSelf.reloadData()
//            }, onError: { error in
//                HUDToast(error.description)
//                strongSelf.mj_header?.endRefreshing()
//                strongSelf.mj_footer?.endRefreshing()
//            }).disposed(by: strongSelf.disBag)
//        })
//    }
//    
//    
//    // MARK: 数据
//    
//    // MARK: 界面
//    
//    // MARK: 事件
//    func beginrefresh() {
//        self.mj_header?.beginRefreshing()
//    }
//    
//    /// 无动画刷新数据
//    func beginRefreshWithNoAnimation() {
//        self.mj_header?.refreshingBlock?()
//    }
//    
//    // MARK: 逻辑
//    
//    // MARK: 代理
//    
//}
