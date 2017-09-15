//
//  ViewController.swift
//  Test
//
//  Created by Matthew Harrilal on 9/14/17.
//  Copyright © 2017 Matthew Harrilal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let network1 = Network()
        print(network1.networking())
    }
}

struct FoldScope {
    let author:String?
    let title:String?
    let description: String?
    let postURL: String?
    init(author:String?, title:String?, description:String?, postURL:String?) {
        self.author = author
        self.title = title
        self.description = description
        self.postURL = postURL
    }
}

extension FoldScope: Decodable {
    
    enum Keys:String, CodingKey {
        case author
        case title
        case description
        case postURL
    }
    
  
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        print(container)
        let author:String = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        let description:String = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        let title:String = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        let postURL:String = try container.decodeIfPresent(String.self, forKey: .postURL) ?? ""
       
        self.init(author: author, title: title, description: description, postURL: postURL)
        
    }
    
}
class Network {
    func networking() {
       let session = URLSession.shared
        let getRequest = URLRequest(url: URL(string: "https://murmuring-coast-82942.herokuapp.com")!)
        session.dataTask(with: getRequest) { (data, response, error) in
            if let data = data {
            
                let foldscope = try? JSONDecoder().decode([FoldScope].self, from: data)
            
            
           
            
        print(foldscope)
            
            }
        }.resume()
        
        // So what is essentially happening is that the reason these are coming up as nil is because we cant access the title of the whole thing where as the poke api we can access the title as well as the other things and grab the neccessary data but here we can not access the  title because we do not have access to the dictionary copmponenets
        
    }
    
}

