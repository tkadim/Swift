//
//  ViewController.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 13.12.2021.
//

import UIKit

class ViewController: UIViewController {    
    
    let networkService = NetworkService()
    var photosSearchResponse: PhotosResponse? = nil
    var roverDataSearchResponse: RoverDataResponse? = nil
    
    let idCell = "tableCell"
    var photosArray: [String] = []
    
    let roversList: [String] = ["Curiosity", "Spirit", "Opportunity", "Perseverance"]
    
    var urlStringPhotosRoverDate: String = "" {
        didSet {
            if (oldValue != urlStringPhotosRoverDate) {

                networkService.jsonPhotosRequest(urlString: self.urlStringPhotosRoverDate) { [weak self] result in
                    switch result {
                    case .success(let searchResponse):
                        self?.photosSearchResponse = searchResponse
                        print("PHOTOS SEARCH RESPONSE: \(searchResponse)")
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error)
                    }
                }

            }
        }
    }
    
    var minRoverDate: Date = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    var maxRoverDate: Date = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
    
    @IBOutlet weak var roverTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var cameraTextField: UITextField!
    
    
    @IBOutlet weak var tableView: UITableView!
    let roverPicker = UIPickerView()
    let datePicker = UIDatePicker()
    
    
    
//    roverTextField.addTarget(self, action: #selector(myTargetFunction), for: .editingDidEnd)
//
//    @objc func myTargetFunction(textField: UITextField) {
//        print("textfield pressed")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        roverPicker.dataSource = self
        roverPicker.delegate = self
        roverTextField.inputView = roverPicker
        
        let roverPickerToolbar = UIToolbar()
        roverPickerToolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        roverPickerToolbar.setItems([flexSpace,doneButton], animated: true)
        roverTextField.inputAccessoryView = roverPickerToolbar
        
        
        
        datePicker.datePickerMode = .date
        dateTextField.inputView = datePicker
        
        
        
        let urlStringRoverData = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(roverTextField.text ?? "")/?api_key=SVQHSr5ac2Pa832khihJP44RefkYp27uzXeRkgn3"
        
        
        networkService.jsonRoverDataRequest(urlString: urlStringRoverData) { [weak self] result in
            switch result {
            case .success(let searchResponse):
                self?.roverDataSearchResponse = searchResponse

                if let maxDate = self?.roverDataSearchResponse?.rover.max_date {
                    self?.datePicker.maximumDate = maxDate
                    self?.dateTextField.text = String(maxDate.description.split(separator: " ")[0])
                    self?.urlStringPhotosRoverDate = "https://api.nasa.gov/mars-photos/api/v1/rovers/\(self?.roverTextField.text ?? "")/photos?earth_date=\(self?.dateTextField.text ?? "")&api_key=SVQHSr5ac2Pa832khihJP44RefkYp27uzXeRkgn3"
                    
                    self?.tableView.reloadData()
                                        
                }
                
                if let minDate = self?.roverDataSearchResponse?.rover.landing_date {
                    self?.datePicker.minimumDate = minDate
                }
            case .failure(let error):
                print(error)
            }
        }
        

    }

    @objc func doneAction() {
        roverTextField.text = roversList[roverPicker.selectedRow(inComponent: 0)]
        view.endEditing(true)
        self.viewDidLoad()
        
    }
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return photosSearchResponse?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idCell) as! PhotoTableViewCell
        
        if let photoObject = photosSearchResponse?.photos[indexPath.row]{

            cell.roverLabel.text = "Rover: \(String(describing: photoObject.rover.name))"
            cell.cameraLabel.text = "Camera: \(String(describing: photoObject.camera.full_name))"
            cell.dateLabel.text = "Date: \(String(describing: photoObject.earth_date))"
            
            if let photoURL = URL(string: photoObject.img_src){
                cell.photoImage.kf.setImage(with: photoURL)
                photosArray.append(photoObject.img_src)
            }

        } else {

            cell.roverLabel.text = "Rover: no data"
            cell.cameraLabel.text = "Camera: no data"
            cell.dateLabel.text = "Date: no data"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        
        let fullScreenImagePage: FullScreenImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "FullScreenImageViewController") as! FullScreenImageViewController
        
//        fullScreenImagePage.selectedImage = self.photosArray[indexPath.row]
        fullScreenImagePage.selectedImage = photosSearchResponse?.photos[indexPath.row].img_src
        
        print("Image URL: \(String(describing: self.photosArray[indexPath.row]))")
        
        self.navigationController?.pushViewController(fullScreenImagePage, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
}

extension ViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roversList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
//        roverTextField.text = roversList[row]
//        roverPicker.selectedRow(inComponent: row)
//        roverTextField.resignFirstResponder()
//        self.viewDidLoad()
    }
    
    
}

extension ViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.roversList[row]
    }
    
    
}
