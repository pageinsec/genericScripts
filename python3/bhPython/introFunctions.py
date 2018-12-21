def sum(num1, num2):
    num1int = convInt(num1)
    num2int = convInt(num2)
    result = num1int + num2int
    return result

def convInt(number_string):
    convertedInt = int(number_string)
    return convertedInt

answer = sum("1", "2")
print (answer)
