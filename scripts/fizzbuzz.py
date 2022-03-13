
with open('/Users/thenuja.viknarajah/file.txt', 'r') as of, open('/Users/thenuja.viknarajah/file2.txt', 'w') as nf:
    for line in of:
        print(line)
        if int(line) % 3 == 0 and int(line) % 5 == 0:
            nf.write('FizzBuzz\n')
        elif int(line) % 3 == 0:
            nf.write('Fizz\n')
        elif int(line) % 5 == 0:
            nf.write('Buzz\n')
        else:
            nf.write('{}'.format(line))
