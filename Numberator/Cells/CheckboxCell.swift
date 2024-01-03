import UIKit

protocol CheckboxCellDelegate: AnyObject {
    func checkboxCell(_ cell: CheckboxCell, didChangeValue isChecked: Bool)
}

class CheckboxCell: UITableViewCell {
    weak var delegate: CheckboxCellDelegate?
    var quiz: Quiz? {
        didSet {
            isChecked = quiz?.answered ?? false
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            checkBoxSwitch.isOn = isChecked
        }
    }

    let checkBoxLabel = UILabel()
    let checkBoxSwitch = UISwitch()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        editingAccessoryType = .none
        editingAccessoryView = nil
        
        checkBoxLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBoxSwitch.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(checkBoxLabel)
        contentView.addSubview(checkBoxSwitch)

        NSLayoutConstraint.activate([
            checkBoxLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkBoxLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkBoxSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkBoxSwitch.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            checkBoxSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
        
        checkBoxSwitch.isOn = quiz?.answered ?? false
        
        checkBoxSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }

    @objc private func switchValueChanged() {
        isChecked = checkBoxSwitch.isOn
        delegate?.checkboxCell(self, didChangeValue: isChecked)
        quiz?.answered = checkBoxSwitch.isOn
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        checkBoxSwitch.isEnabled = editing
    }
    
}
