import UIKit

struct Student {
    
    let firstName: String
    let lastName: String
    let yearOfBirth: Int
    var averageScore: Int
}

let student1 = Student(firstName: "Petr", lastName: "Ivanov", yearOfBirth: 1980, averageScore: 5)
let student2 = Student(firstName: "Vladimir", lastName: "Petrov", yearOfBirth: 1981, averageScore: 4)

var students: [Student] = [student1, student2]


func printStudentsInfo(students: [Student]) {
    var item = 1
    
    for student in students {
        print("\(item). Student name: \(student.firstName), Student average score: \(student.averageScore)")
        item += 1
    }
}

//printStudentsInfo(students: students)

printStudentsInfo(students:students.sorted { $0.averageScore < $1.averageScore})
