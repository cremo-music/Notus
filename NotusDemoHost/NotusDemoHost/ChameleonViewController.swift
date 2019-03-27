import UIKit
import Notus

class ChameleonViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var playButton: UIButton!    
    var delegate: PlayDelegate!
    
    var pickerData: [String] = ["None", "Staccato", "Legato",
                                "Crescendo (PPP to FFF)", "Diminuendo (FFF to PPP)", "Crescendo (relative)", "Diminuendo (relative)",
                                "Ritardando", "Accelerando"]
    
    @IBAction func playAction(_ sender: UIButton) {
        do {
            delegate.playAction(play: !sender.isSelected, button: sender, song: try chameleon())
            sender.isSelected = !sender.isSelected
        }
        catch let error {
            print("error: creating music sequence failed: \(error)")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
