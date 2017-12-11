//
//  MainViewController.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/6/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

//class MainViewController: UIViewController {
//
//    @IBOutlet weak var collectionView: UICollectionView!
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
//
//    fileprivate var photoModelArray:[ImageModel] = []
//    fileprivate var photosDict:[String:UIImage] = [:]
//
//
//    fileprivate var gridLayout:UICollectionViewFlowLayout {
//        get {
//            let layout = UICollectionViewFlowLayout()
//            let itemSpacing: CGFloat = 3
//            let itemsInOneLine:CGFloat = 3
//            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//            let width = UIScreen.main.bounds.size.width - itemSpacing * (itemsInOneLine - CGFloat(1))
//            layout.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
//            layout.minimumInteritemSpacing = 3
//            layout.minimumLineSpacing = 3
//            return layout
//        }
//    }
//    fileprivate var listLayout:UICollectionViewFlowLayout {
//        get {
//            let layout = UICollectionViewFlowLayout()
//            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
//            let width = UIScreen.main.bounds.size.width
//            layout.itemSize = CGSize(width: width, height: width/3)
//            layout.minimumInteritemSpacing = 3
//            layout.minimumLineSpacing = 3
//            return layout
//        }
//    }
//
//    private var isShowGrid:Bool = true {
//        didSet {
//            print(isShowGrid)
//            if self.collectionView != nil {
//                self.collectionView.collectionViewLayout = isShowGrid ? gridLayout : listLayout
//            }
//        }
//    }
//
//    @IBAction func segmentedDidChanged(_ sender: Any) {
//        guard let segmented = sender as? UISegmentedControl else { return }
//        isShowGrid = segmented.selectedSegmentIndex == 0 ? true : false
//    }
//
//    func callAPI() {
////        let urlString = "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&method=flickr.photos.search"
//        let urlString = "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&format=json&per_page=50&method=flickr.photos.getrecent&nojsoncallback=1"
//        if let url = URL(string: urlString) {
//            var request = URLRequest(url: url)
//            request.httpMethod = "GET"
//            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                if error != nil {
//                    self.showAlertVC()
//                }
//                if let data = data, let json = try! JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) as? Dictionary<String, Any> {
//                    print(json)
//                    if (json["stat"] as? String) == "ok" {
//                        if let photosJSON = json["photos"] as? Dictionary<String,Any> {
//                            self.getImages(photoJson: photosJSON["photo"] as? [Dictionary<String,Any>] ?? [])
//                        }
//                    } else {
//                        self.showAlertVC()
//                    }
//                }
//
//            }).resume()
//        }
//    }
//
//    fileprivate func getImages(photoJson:[Dictionary<String,Any>], page:Int = 1) {
//        for aJson in photoJson {
//            let photoObj = ImageModel(json: aJson)
//            self.photoModelArray.append(photoObj)
//        }
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
//    }
//
//    fileprivate func showAlertVC() {
//        let alertView = UIAlertController(title: "Flickr Image Viewer", message: "Could not load images", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
//            alertView.dismiss(animated: true, completion: nil)
//        })
//        alertView.addAction(action)
//        self.navigationController?.present(alertView, animated: true, completion: nil)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.black
//        segmentedControl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*0.75, height: segmentedControl.frame.size.height)
//        segmentedControl.setTitle("Grid View", forSegmentAt: 0)
//        segmentedControl.setTitle("List View", forSegmentAt: 1)
//        segmentedControl.selectedSegmentIndex = 0
//
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        let nib = UINib(nibName: "GridCollectionViewCell", bundle: nil)
//        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
//        collectionView.collectionViewLayout = gridLayout
//
//        self.callAPI()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    fileprivate func loadImage(link:String, imageView:UIImageView) {
//        if let url = URL(string: link) {
//            CommonUtils().downloadImage(url: url, callback: { [weak self] (aImage) in
//                guard let strongSelf = self else { return }
//                if aImage != nil {
//                    DispatchQueue.main.async {
//                        strongSelf.photosDict[link] = aImage
//                        imageView.image = aImage
//                    }
//                }
//            })
//        }
//    }
//}
//
//extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.photoModelArray.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
//        cell.tag = indexPath.item
//        cell.imgView.image = nil
//        if cell.tag == indexPath.item {
//            let obj = self.photoModelArray[indexPath.item]
////            let image = self.photosDict[obj.id]
////            if image != nil {
////                cell.imgView.image = image
////            } else {
////                cell.loadImage(photoObj: obj, image: image, callback: { [weak self] (imgTuple) in
////                    if imgTuple != nil {
////                        self?.photosDict[obj.id]  = imgTuple!.image
////                    }
////                })
////            }
//
//            if photosDict[obj.returnImageURL()] != nil {
//                cell.imgView.image = photosDict[obj.returnImageURL()]
//            } else {
//                self.loadImage(link: obj.returnImageURL(), imageView: cell.imgView)
//            }
//        }
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
////        cell.imgView.image = nil
//        cell.tag = indexPath.item
//        DispatchQueue.main.async {
//            if cell.tag == indexPath.item {
//                let obj = self.photoModelArray[indexPath.item]
//                if self.photosDict[obj.returnImageURL()] != nil {
//                    cell.imgView.image = self.photosDict[obj.returnImageURL()]
//                } else {
//                    self.loadImage(link: obj.returnImageURL(), imageView: cell.imgView)
//                }
//            }
//        }
//        return cell
//    }
//}

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    fileprivate var photoModelArray:[ImageModel] = []
    fileprivate var photosDict:[String:UIImage] = [:]
    fileprivate var currentPage:Int = 1
    fileprivate var totalPage:Int = 1
    fileprivate var isSearching = false
    
    fileprivate var gridLayout:UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout()
            let itemSpacing: CGFloat = 3
            let itemsInOneLine:CGFloat = 3
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            let width = UIScreen.main.bounds.size.width - itemSpacing * (itemsInOneLine - CGFloat(1))
            layout.itemSize = CGSize(width: floor(width/itemsInOneLine), height: width/itemsInOneLine)
            layout.minimumInteritemSpacing = 3
            layout.minimumLineSpacing = 3
            return layout
        }
    }
    fileprivate var listLayout:UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
            let width = UIScreen.main.bounds.size.width
            layout.itemSize = CGSize(width: width, height: width/3)
            layout.minimumInteritemSpacing = 3
            layout.minimumLineSpacing = 3
            return layout
        }
    }
    
    private var isShowGrid:Bool = true {
        didSet {
            print(isShowGrid)
            if self.collectionView != nil {
                self.collectionView.collectionViewLayout = isShowGrid ? gridLayout : listLayout
            }
        }
    }
    
    @IBAction func segmentedDidChanged(_ sender: Any) {
        guard let segmented = sender as? UISegmentedControl else { return }
        isShowGrid = segmented.selectedSegmentIndex == 0 ? true : false
    }
    
    func callAPI() {
//        let urlString = String(format: "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&format=json&per_page=25&page=%d&method=flickr.photos.getrecent&nojsoncallback=1", arguments: [self.currentPage])
        let urlString = String(format: "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&format=json&per_page=25&page=%d&method=flickr.interestingness.getlist&nojsoncallback=1", arguments: [self.currentPage])
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                self.isSearching = false
                if error != nil {
                    self.showAlertVC()
                }
                if let data = data, let json = try! JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) as? Dictionary<String, Any> {
                    print(json)
                    if (json["stat"] as? String) == "ok" {
                        if let photosJSON = json["photos"] as? Dictionary<String,Any> {
                            self.totalPage = json["pages"] as? Int ?? 1
                            if self.totalPage <= self.currentPage {
                                self.getImages(photoJson: photosJSON["photo"] as? [Dictionary<String,Any>] ?? [])
                                self.currentPage += 1
                            }
                        }
                    } else {
                        self.showAlertVC()
                    }
                }
            }).resume()
        }
    }
    
    fileprivate func getImages(photoJson:[Dictionary<String,Any>], page:Int = 1) {
        for aJson in photoJson {
            let photoObj = ImageModel(json: aJson)
            self.photoModelArray.append(photoObj)
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func showAlertVC() {
        let alertView = UIAlertController(title: "Flickr Image Viewer", message: "Could not load images", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alertView.dismiss(animated: true, completion: nil)
        })
        alertView.addAction(action)
        self.navigationController?.present(alertView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        segmentedControl.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width*0.75, height: segmentedControl.frame.size.height)
        segmentedControl.setTitle("Grid View", forSegmentAt: 0)
        segmentedControl.setTitle("List View", forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "GridCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.collectionViewLayout = gridLayout
        
        self.callAPI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCollectionViewCell
                cell.tag = indexPath.item
                cell.imgView.image = nil
                if cell.tag == indexPath.item {
                    let obj = self.photoModelArray[indexPath.item]
                    if let url = URL(string: obj.returnImageURL()) {
                        cell.imgView.downloadImage(url: url, callback: { (aImage) in

                        })
                    }
                }
        
//        cell.tag = indexPath.item
//        cell.imgView.image = nil
//        if cell.tag == indexPath.item {
//            let obj = self.photoModelArray[indexPath.item]
//            let image = self.photosDict[obj.id]
//            if image != nil {
//                cell.imgView.image = image
//            } else {
//                cell.loadImage(photoObj: obj, image: image, callback: { [weak self] (imgTuple) in
//                if imgTuple != nil {
//                    self?.photosDict[obj.id]  = imgTuple!.image
//                }
//            })
//        }
//        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let obj = self.photoModelArray[indexPath.item]
        let VC = storyboard?.instantiateViewController(withIdentifier: "ImageDetailVC") as! ImageDetailViewController
        VC.photoObj = obj
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewY = Int(scrollView.contentOffset.y + scrollView.frame.size.height)
        let bottomScroll = Int(scrollView.contentSize.height + scrollView.contentInset.bottom)
        if (scrollViewY >= bottomScroll ) {
            if isSearching == false
            {
                isSearching = true
                self.callAPI()
                
            }
        }
    }
}

