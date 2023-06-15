//
//  ViewController.swift
//  Memes (Networking)
//
//  Created by Luka Gujejiani on 16.06.23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //somehow fixes the timing issue, without didSet {} the content wasn't being downloaded properly and tableView would show nothing
    
    private var memeResponse: MemeResponse? {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        Task {
            do {
                memeResponse = try await getMemes()
            } catch APIError.invalidData{
                print("invalidData")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeResponse?.data.memes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        if let meme = memeResponse?.data.memes[indexPath.row] {
            cell.textLabelForMemeName.text = meme.name
            cell.memeImage?.image = nil // Reset the image to avoid displaying incorrect images
                        if let photoURL = URL(string: meme.url) {
                            DispatchQueue.global().async {
                                if let data = try? Data(contentsOf: photoURL) {
                                    let image = UIImage(data: data)
                                    DispatchQueue.main.async {
                                        cell.memeImage?.image = image
                                    }
                                }
                            }
                        }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}









//    func printMemes() {
//        if let memes = memeResponse?.data.memes {
//            for meme in memes {
//                print("Meme name: \(meme.name)")
//                print("Meme URL: \(meme.url)")
//                print("----------")
//            }
//        }
//    }

