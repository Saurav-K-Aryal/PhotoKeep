//
//  CollectionViewController.swift
//  PhotoKeep
//
//  Created by Saurav Aryal on 4/5/16.
//  Copyright © 2016 Saurav Aryal. All rights reserved.
//

import Foundation

import UIKit


class CollectionViewCrtl: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    var imageArray:[SomeImage] = []
    var returnedObject:SomeImage = SomeImage();
    
    let someImageStore = KCSLinkedAppdataStore.storeWithOptions([
        KCSStoreKeyCollectionName: "Some-Image-collection",
        KCSStoreKeyCollectionTemplateClass : SomeImage.self
        ])
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        
        someImageStore.queryWithQuery(KCSQuery(), withCompletionBlock: { (response, error) -> Void in
    
            
            for imageObject in response{
                
                print(imageObject )
                
                self.returnedObject = imageObject as! SomeImage;
                self.imageArray.append(self.returnedObject)
                
                
            }
            self.collectionView.reloadData();
            }, withProgressBlock: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell;
        
        let item = self.imageArray[indexPath.row];
        
        cell.cellImage.image = item.someImage;
        
        return cell;
    }
    
}



    

