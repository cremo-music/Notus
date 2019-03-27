import UIKit
import Notus

class CanineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var picker: UIPickerView!
    var delegate: PlayDelegate!
    
    var pickerData: [String] = ["None", "Todo"]
    
    @IBAction func playAction(_ sender: UIButton) {
        do {
            delegate.playAction(play: !sender.isSelected, button: sender, song: try canine())
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
