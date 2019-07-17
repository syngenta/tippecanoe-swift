//
//  ViewController.swift
//  Demo
//
//  Created by Evegeny Kalashnikov on 7/12/19.
//  Copyright © 2019 Evegeny Kalashnikov. All rights reserved.
//

import UIKit
import tippecanoe_swift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func render() {
        guard let input = Bundle.main.path(forResource: "poligons", ofType: "json") else {
            return
        }

        let output = NSTemporaryDirectory().appending("out.mbtiles")

        let tpc = Tippecanoe(input: input, output: output)

        tpc.render(progress: { progress in
            print(progress)
        }, completion: { result in
            switch result {
            case .success:
                print("done - \(output)")
            case .failure(let error):
                print("failure - \(error)")
            }
        })
    }
}
