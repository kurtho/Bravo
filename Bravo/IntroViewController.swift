//
//  IntroViewController.swift
//  Bravo
//
//  Created by KurtHo on 2016/8/12.
//  Copyright © 2016年 Kurt. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}



extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IntroContent.contents.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as! IntroPageCollectionViewCell
        cell.myImage.image = UIImage(named: IntroContent.contents[indexPath.row].myImage)
        cell.myLabel.text = IntroContent.contents[indexPath.row].myLabel
        return cell
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let screenSize: CGRect = UIScreen.mainScreen().bounds

        return CGSize(width: screenSize.width, height: screenSize.width * 1.5)
    }
    
    
    

}



class IntroContent {
    static let contents = [
        IntroContent(myImage: "moon", myLabel: "測試一"),
        IntroContent(myImage: "me", myLabel: "測試二"),
        IntroContent(myImage: "moon", myLabel: "測試三")
    ]
    let myImage: String
    let myLabel: String
    
    init(myImage: String, myLabel: String ) {
        self.myImage = myImage
        self.myLabel = myLabel
    }
}