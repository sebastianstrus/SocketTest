//
//  ViewController.swift
//  SocketTest
//
//  Created by Sebastian Strus on 2018-03-27.
//  Copyright © 2018 Sebastian Strus. All rights reserved.
//

import UIKit
import SwiftSocket


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let client = TCPClient(address: "192.168.20.111", port: 5188)

        switch client.connect(timeout: 6) {
        case .success:
            //sleep(1)
            switch client.send(string: "47\n{\"version\":\"1\",\"message_type\":\"get_properties\"}" ) {
            case .success:
                sleep(1)
                guard let data = client.read(1024*10) else { return }
                
                if let response = String(bytes: data, encoding: .utf8) {
                    print("response: \(response)")
                }
            case .failure(let error):
                print("1: \(error)")
            }
        case .failure(let error):
            print("2: \(error)")
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

