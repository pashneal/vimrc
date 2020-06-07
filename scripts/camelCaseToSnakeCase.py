import re

test = "thisIsCamelCase thisIsAlsoCamelCase thisIACamelCase ANDTHISISNOT andthisisnot andThisisSomewhatCamel_Here THIS_IS_JUST_BAD thisisNOtNOTCamel_ testCamillaCasa"
x = re.compile(r'([a-z]+([A-Z][a-z]*)+)')
print(x.findall(test))
