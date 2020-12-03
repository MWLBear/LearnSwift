
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count-1)
print(list)

var arrary = [ 5, 3, 8]

let a = partitionHoare(&arrary, low: 0, high: arrary.count-1)
print("---")
print(arrary[a])
print(a)
