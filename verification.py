import sys

""" Python file to verify the result given my haskell. """


def compare_result(result, file):
    result_content = open(result,'r').read()
    file_content = open(file,'r').read()

    grid_result = result_content.split(',')
    grid_file = file_content.split(',')

    grid_result = list(filter(lambda k : k != "",grid_result))
    grid_file = list(filter(lambda k : k != "",grid_file))

    duplicates = []
    for grid in grid_result:
        if grid in grid_file:
            duplicates.append(grid)

    return duplicates

if __name__ == '__main__':
    try:
        haskell_result = sys.argv[1]
        haskell_file_1 = sys.argv[2]
        haskell_file_2 = sys.argv[3]
        print("starting verfication!")
        dups1 = compare_result(haskell_result,haskell_file_1)
        print("entries from result in file one: " + str(len(dups1)))
        dups2 = compare_result(haskell_result,haskell_file_2)
        print("entries from result in file two: " + str(len(dups2)))
        print("verification complete!")
    except: # General errors might be due to wrongly calling the verification script
        print("Correct usage: python verification.py [resulting_file] [file1] [file2]")
