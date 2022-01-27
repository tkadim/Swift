import UIKit

//struct Student {
//
//    let firstName: String
//    let lastName: String
//    let yearOfBirth: Int
//    var averageScore: Int
//}
//
//let student1 = Student(firstName: "Alex", lastName: "Ivanov", yearOfBirth: 1980, averageScore: 5)
//let student2 = Student(firstName: "Vladimir", lastName: "Petrov", yearOfBirth: 1981, averageScore: 4)
//let student3 = Student(firstName: "Petr", lastName: "Ivanov", yearOfBirth: 1981, averageScore: 6)
//
//var students: [Student] = [student1, student2, student3]
//
//
//func printStudentsInfo(students: [Student]) {
//    var item = 1
//
//    for student in students {
//        print("\(item). Student name: \(student.firstName), Student last name: \(student.lastName)")
//        item += 1
//    }
//}

//printStudentsInfo(students: students)

//printStudentsInfo(students:students.sorted {
//    if $0.lastName == $1.lastName {
//        return $0.firstName < $1.firstName
//    } else {
//        return $0.lastName < $1.lastName
//    }
//})

class Human {
    let name: String
    let lastName: String
    var age: Int {
        didSet{
            if age < 0 || age > 200 {
                age = oldValue
            }
        }
    }
    static var numberOfObjects = 0
    
    init(name: String, lastName: String, age: Int) {
        self.name = name
        self.lastName = lastName
        self.age = age
        Human.numberOfObjects += 1
    }
}

let human1 = Human(name: "Ben", lastName: "Black", age: 20)
let human2 = Human(name: "Den", lastName: "Black", age: 20)

print("\(Human.numberOfObjects)  \(human1.age)")

