---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by javat.
--- DateTime: 2022/5/24 下午 12:44
---

-- Lua strings are immutable values.
-- We can delimit literal strings by single or double matching quotes:

a = "one string"
b = string.gsub(a, "one", "another") -- change string parts
print(a) --> one string
print(b) --> another string

-- We can get the length of a string using the length operator (denoted by #)
-- This operator always counts the length in bytes, which is not the same as characters in some encodings.
a = "hello"
print(#a) --> 5
print(#"good bye") --> 8

b = "哈羅"
print(#b)
print(string.byte(b,1,-1))
print(utf8.codepoint(b,1,-1))
--We can concatenate two strings with the concatenation operator .. (two dots).
--If any operand is a number, Lua converts this number to a string:

print("Hello " .. "World")  --Hello World
print("result is " .. 3)  --result is 3
print(4 .. 3)  --result is 3
--print(4.. 3)  --need space b/w number and ..

--[[
We can specify a character in a literal string also by its numeric value through the escape sequences \ddd
and \xhh, where ddd is a sequence of up to three decimal digits and hh is a sequence of exactly two
hexadecimal digits.

Since Lua 5.3, we can also specify UTF-8 characters with the escape sequence \u{h... h}; we can
write any number of hexadecimal digits inside the brackets:
]]
print('\x41\x4c\x4f\x31\x32\x33\x22\x0a') -- ALO123"\n
print('\u{738b}\u{5c0f}\u{660e}') --王小明

--[[
Long Strings:
We can delimit literal strings also by matching double square brackets.
Literals in this bracketed form can run for several lines and do not interpret escape sequences.
Moreover, it ignores the first character of the string when this character is a newline
]]
page = [[
<html>
<head>
<title>An HTML Page</title>
</head>
<body>
<a href="http://www.lua.org">Lua</a>
</body>
</html>
]]
print(page)

-- problem with code containing ]] --> use '[===[' (with any number of equal signs b/w two opening brackets)
-- the same with multiline comments
code = [=====[
a = b[c[i]]
]=====]

print(code)
--[[
Coercions(automatically convert b/w numbers and strings):

Lua provides automatic conversions between numbers and strings at run time.
Any numeric operation applied to a string tries to convert the string to a number.
To convert a string to a number explicitly, we can use the function tonumber, which returns nil if the
string does not denote a proper number.
> tonumber(" -3 ") --> -3
> tonumber(" 10e4 ") --> 100000.0
> tonumber("10e") --> nil (not a valid number)
> tonumber("0x1.3p-4") --> 0.07421875
]]

--[[
String library:

string.len(s) --> #s
string.rep(s,n) -->  returns the string s repeated n times
string.sub(s, i, j) --> extracts a piece of the string s, from the i-th to the j-th character
inclusive. (The first character of a string has index 1.)
We can also use negative indices, which count from the end of the string: index -1 refers to the last character,
]]

print(string.rep("abc", 3))--> abcabcabc
print(string.reverse("A Long Line!")) --> !eniL gnoL A
print(string.lower("A Long Line!")) --> a long line!
print(string.upper("A Long Line!")) --> A LONG LINE!

s = "[in brackets]"
print(string.sub(s, 2, -2)) --> in brackets
print(string.sub(s, 1, 1)) --> [
print(string.sub(s, -1, -1)) --> ]

--[[
The functions string.char and string.byte convert between characters and their internal numeric
representations.
]]
print(string.char(97)) -->a
i = 99; print(string.char(i, i+1, i+2)) -->cde
print(string.byte("abc")) -->97
print(string.byte("abc", 2)) -->98
print(string.byte("abc", -1)) -->99
print(string.byte("abc", 2,3)) -->98 99

--[[
string.format():  The directives in the format string have rules similar to those of the C function printf.
]]
s = string.format("x = %d y = %d", 10, 20)

--[[
We can call all functions from the string library as methods on strings, using the colon operator.
For instance, we can rewrite the call string.sub(s, i, j) as s:sub(i, j); string.upper(s) as s:upper().
]]


--[[
 pattern matching:
string.find("hello world", "wor") --> 7 9
string.find("hello world", "war")--> nil
]]


s,e = string.find("hello world", "wor")
print(string.format("start=%d, end=%d", s,e))
print(string.find("hello world", "ppp"))


--[[
string.gsub (Global SUBstitution) replaces all occurrences of a pattern in a string with another string
It also returns, as a second result, the number of replacements it made.

> string.gsub("hello world", "l", ".") --> he..o wor.d 3
> string.gsub("hello world", "ll", "..") --> he..o world 1
> string.gsub("hello world", "a", ".") --> hello world 0
]]

-- The functions utf8.char and utf8.codepoint are the equivalent of string.char and
-- string.byte in the UTF-8 world:
s= utf8.char(114, 233, 115, 117, 109, 233)
print(s) -->résumé
print(#s) -->8
t,u = utf8.codepoint("résumé", 6, 8)
print(utf8.char(t))
print(utf8.char(u))