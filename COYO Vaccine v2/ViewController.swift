//
//  ViewController.swift
//  COYO Vaccine v2
//
//  Created by Turushan Aktay on 02.06.21.
//

import Cocoa
import WebKit

class ViewController: NSViewController {

    @IBOutlet weak var codeTextField: NSTextField!
    @IBOutlet weak var nextZipLabel: NSTextField!
    @IBOutlet weak var infoLabel: NSTextField!
    @IBOutlet weak var tryAgainButton: NSButton!
    @IBOutlet weak var webView: WKWebView!

    let zipCodes: [String] = ["20038", "20095", "20097", "20099", "20144", "20146", "20148", "20149", "20249", "20251", "20253", "20255", "20257", "20259", "20354", "20355", "20357", "20359", "20457", "20459", "20535", "20537", "20539", "21029", "21031", "21033", "21035", "21037", "21039", "21073", "21075", "21077", "21079", "21107", "21109", "21129", "21147", "21149", "22041", "22043", "22045", "22047", "22049", "22081", "22083", "22085", "22087", "22089", "22111", "22115", "22117", "22119", "22143", "22145", "22147", "22149", "22159", "22175", "22177", "22179", "22297", "22299", "22301", "22303", "22305", "22307", "22309", "22335", "22337", "22339", "22359", "22391", "22393", "22395", "22397", "22399", "22415", "22417", "22419", "22453", "22455", "22457", "22459", "22523", "22525", "22527", "22529", "22547", "22549", "22559", "22587", "22589", "22605", "22607", "22609", "22761", "22763", "22765", "22767", "22769"]

    var zipIndex = 0

    var hasCode = false {
        didSet {
            zipIndex = 0
            tryAgainButton.alphaValue = 1
            nextZipLabel.alphaValue = 1
            infoLabel.alphaValue = 1
            codeTextField.alphaValue = hasCode ? 1 : 0
            infoLabel.stringValue = hasCode ? "Fill your 'Vermittlungscodes / Meditation code' and press try again, unfortunately I don't remember current flow with code,  just send me screenshot @turushan so I can write here useful information :D if there is no termin, just press try again and repeat" : "To get your 'Vermittlungscodes / Meditation code' click 'Nein' below and wait for 'Gehören Sie einer impfberechtigten Personengruppen an?', then click 'Ja' and enter your age. If that question doesn't appear just press try again, and repeat :)"

            if !hasCode {
                let request = URLRequest(url: URL(string: "https://353-iz.impfterminservice.de/impftermine/service?plz=20038")!)
                webView.load(request)
                zipIndex = 1
                nextZipLabel.stringValue = "Next zip: 20095"
            } else {
                nextZipLabel.stringValue = "Next zip: 20038"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        codeTextField.alphaValue = 0
        tryAgainButton.alphaValue = 0
        nextZipLabel.alphaValue = 0
        infoLabel.alphaValue = 0
    }

    @IBAction func yesTapped(_ sender: Any) {
        hasCode = true
    }

    @IBAction func noTapped(_ sender: Any) {
        hasCode = false
    }

    @IBAction func tryAgainTapped(_ sender: Any) {
        if zipIndex >= zipCodes.count {
            zipIndex = 0
        }
        var request: URLRequest
        if hasCode {
            request = URLRequest(url: URL(string: "https://353-iz.impfterminservice.de/impftermine/suche/\(codeTextField.stringValue)/\(zipCodes[zipIndex])")!)
        } else {
            request = URLRequest(url: URL(string: "https://353-iz.impfterminservice.de/impftermine/service?plz=\(zipCodes[zipIndex])")!)
        }
        webView.load(request)
        zipIndex += 1
        nextZipLabel.stringValue = "Next zip: \(zipCodes[zipIndex])"
    }
}

