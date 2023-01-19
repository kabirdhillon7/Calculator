//
//  ContentView.swift
//  Calculator
//
//  Created by Kabir Dhillon on 1/17/23.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtrack, multiply, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperator: Operation? = .none
    
    var buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Text Display
                HStack{
                    Spacer()
                    
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                }
                .padding()
                
                // Our Buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        
        switch button {
        case .add, .subtract, .divide, .multiply, .equal:
            if button == .add {
                self.currentOperator = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperator = .subtrack
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperator = .multiply
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperator = .divide
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                
                switch self.currentOperator {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtrack: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                case .some(.none):
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            break
        case .decimal:
            if self.value.contains(".") {
                return
            } else {
                self.value = "\(self.value)."
            }
        case .negative:
            if self.value.contains("-") {
                let positiveValue = (Int(self.value) ?? 0) * -1
                self.value = "\(positiveValue)"
            } else {
                let negativeValue = (Int(self.value) ?? 0) * -1
                self.value = "\(negativeValue)"
            }
        case .percent:
            let newValue = (Double(self.value) ?? 0) * 0.01
            self.value = "\(newValue)"
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
