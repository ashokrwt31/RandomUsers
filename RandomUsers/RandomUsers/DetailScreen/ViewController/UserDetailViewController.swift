//
//  UserDetailVC.swift
//  RandomUsers
//
//  Created by Ashok Rawat on 23/05/23.
//

import Foundation

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var ageDisplayView: CustomAgeView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var doj: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var postalcode: UILabel!
    
    var detailViewModel: UserDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfileImage()
        setUserAddressInfo()
        setUserPersonalInfo()
        setUserAge()
    }
    
   @objc func updateDetailViewModel(_ viewModel: UserListModel) {
        detailViewModel = UserListWrapper().createUserDetailViewModel(viewModel)
    }
    
    private func setProfileImage() {
        let url: URL = URL(string: detailViewModel?.largeImageURL ?? "")!
        let placeholderImage: UIImage? = UIImage(named: "placeholder")
        UIImage.loadImage(from: url) { [weak self] image in
            self?.profileImage.image = image != nil ? image : placeholderImage
        }
    }
    
    private func setUserAddressInfo() {
        if let viewModel = detailViewModel {
            city.text = viewModel.city
            state.text = viewModel.state
            country.text = viewModel.country
            postalcode.text = viewModel.postalcode
            
        }
    }
    
    private func setUserPersonalInfo() {
        if let viewModel = detailViewModel {
            email.text = viewModel.email
            doj.text = viewModel.formattedDOJ
            dob.text = viewModel.formattedDOB
            self.title = viewModel.name
        }
    }
    
    func setUserAge() {
        if let viewModel = detailViewModel {
            ageDisplayView.ageLabel.text = viewModel.age
        }
    }
}
