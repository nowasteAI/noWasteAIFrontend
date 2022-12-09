//
//  ViewController.swift
//  noWasteAI
//
//  Created by Tej Guntuku on 11/28/22.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let imagePicker = UIImagePickerController()
    
//    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 125
        
//        navigationController?.navigationBar.barTintColor = UIColor(red: 53, green: 79, blue: 120, alpha: 1)
//        navigationController?.navigationBar.tintColor = UIColor(red: 53, green: 79, blue: 120, alpha: 1)
//        navigationController.isTranslucent = false

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor(red: 53/255.0, green: 79/255.0, blue: 120/255.0, alpha: 1.0)

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 53/255.0, green: 79/255.0, blue: 120/255.0, alpha: 1.0)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.tintColor = UIColor(red: 53/255.0, green: 79/255.0, blue: 120/255.0, alpha: 0.99)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
   }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        images.append((info[UIImagePickerController.InfoKey.originalImage] as? UIImage)!)
        
        
//        imageView.image = userPickedImage as? UIImage
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        tableView.reloadData()
        
    }

    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Return items count
        return images.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Return cell
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
        cell.backgroundView = UIImageView(image: images[indexPath.item])
        cell.backgroundView?.contentMode = UIView.ContentMode.scaleAspectFill
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            images.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 15
        let horizontalPadding: CGFloat = 20

        let maskLayer = CALayer()
        maskLayer.cornerRadius = 10    //if you want round edges
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: horizontalPadding/2, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
}

