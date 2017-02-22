//
//  FiltersVC.swift
//  KhanAcademyBadges
//
//  Created by Jonathan Wang on 1/15/17.
//  Copyright © 2017 JonathanWang. All rights reserved.
//

import UIKit

class FiltersVC: UIViewController {

    @IBOutlet var meteoriteSwitch: UISwitch!
    @IBOutlet var challengeSwitch: UISwitch!
    @IBOutlet var blackHoleSwitch: UISwitch!
    @IBOutlet var sunSwitch: UISwitch!
    @IBOutlet var earthSwitch: UISwitch!
    @IBOutlet var moonSwitch: UISwitch!
    @IBOutlet var challengeImageView: UIImageView!
    @IBOutlet var blackHoleImageView: UIImageView!
    @IBOutlet var sunImageView: UIImageView!
    @IBOutlet var earthImageView: UIImageView!
    @IBOutlet var moonImageView: UIImageView!
    @IBOutlet var meteoriteImageView: UIImageView!
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        challengeImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/master-challenge-blue-small.png")
        blackHoleImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/eclipse-small.png")
        sunImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/sun-small.png")
        earthImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/earth-small.png")
        moonImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/moon-small.png")
        meteoriteImageView.image = image(forUrl: "https://cdn.kastatic.org/images/badges/meteorite-small.png")
        
    }
    
    func image(forUrl: String) -> UIImage? {
        let data = try? Data(contentsOf: URL(string: forUrl)!)
        return UIImage(data: data!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func sliderChanged(_ sender: Any) {
        self.pointsLabel.text = String(Int(self.slider.value))
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        //let leastPoints = Int(self.slider.value)
        
        let alert = UIAlertController(title: "", message: "Filters saved!", preferredStyle: .alert)
        
        let savedAction = UIAlertAction(title: "Ok", style: .default, handler: { (savedAction : UIAlertAction!) in
            self.performSegue(withIdentifier: "Save", sender: self)
        })
        
        alert.addAction(savedAction)
        self.present(alert, animated: true, completion: nil)
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "Save") {
            let dest = segue.destination as! BadgesVC
            dest.filters["Meteorite"] = self.meteoriteSwitch.isOn
            dest.filters["Moon"] = self.moonSwitch.isOn
            dest.filters["Earth"] = self.earthSwitch.isOn
            dest.filters["Sun"] = self.sunSwitch.isOn
            dest.filters["Black Hole"] = self.blackHoleSwitch.isOn
            dest.filters["Challenge Patch"] = self.challengeSwitch.isOn
        }

        
    }
    

}
