//
//  ApiManager.swift
//  Tumblr
//
//  Created by Kamil Kosowski on 11.01.2017.
//  Copyright © 2017 Kamil Kosowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ApiManager {
    
    func requestPosts(endpoint: Endpoint) -> Observable<[ApiPost]>  {
        guard let url = URL.urlFor(endpoint: endpoint) else { return Observable.empty() }
        let request = URLRequest(url: url)
        return URLSession.shared.rx.fetchRequest(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ $0.0.parse() }
            .shareReplay(1)
    }
    
    func fetchImage(_ imageView: UIImageView, imagePath: String, post: Post, completion: @escaping (_ data: Data) -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: imagePath) else { return nil }
        return URLSession(configuration: .ephemeral).dataTask(with: url) { data, response, error in
            guard let myData = data else { return }
            guard let image = UIImage(data: myData) else { return }
            
            DispatchQueue.main.async {
                print("API: ImageView height before update: ", imageView.frame.size.height)
                print("API: new image size: ", image.size.height)
                UIView.animate(withDuration: 0.1, animations: { 
                    imageView.snp.updateConstraints {
                        $0.height.equalTo(image.size.height)
                    }
                })
                imageView.image = image
                print("API: ImageView after update: ", imageView.frame.size.height)
                
                post.smallPhoto = myData
                completion(myData)
            }
        }

    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}
