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


    var i = 0

    @IBAction func render() {
        self.i += 1


        guard let input = Bundle.main.path(forResource: "fields", ofType: "json") else {
            return
        }

        let output = NSTemporaryDirectory().appending("out\(self.i).mbtiles")

        let tpc = Tippecanoe(input: input, output: output)

        tpc.render(progress: { progress in
            print(progress)
        }, completion: { result in
            switch result {
            case .success:
                print("done")
            case .failure(_):
                print("failure")
            }
        })

        print(output)
    }
}

