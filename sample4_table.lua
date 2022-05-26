---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by javat.
--- DateTime: 2022/5/24 下午 12:44
---

--[[
We use tables to represent arrays, sets, records, etc
Lua uses tables to represent packages and objects as well
When we write math.sin, we think about “the function sin from the math library”.
For Lua, this expression means “index the table math using the string "sin" as the key”.

A table in Lua is essentially an associative array.
A table is an array that accepts not only numbers as indices,
but also strings or any other value of the language (except nil).

Tables in Lua are neither values nor variables; they are objects.
You may think of a table as a dynamically-allocated object;
programs manipulate only references (or pointers) to them.
Lua never does hidden copies or creation of new tables behind the scenes.
]]

--We create tables by means of a constructor expression, which in its simplest form is written as {}:

a = {}
a['color']= 'red'
a[2] = 100
a[5.5] = 5.5
print(a['color'])
print(a[2])
print(a[5.5])

b = a -- 'b' refers to the same table as 'a'
print(b[2])
print(b[3]) --> nil
b[5.5]=nil
print(a[5.5]) -->nil
a=nil -- only 'b' still refers to the table
b=nil -- no references left to the table


-- use table to represent structures
player={}
player["name"]="Johnny"
player.age = 20
print(player["age"])
print(player.name)

--[[
A common mistake for beginners is to confuse a.x with a[x]. The first form represents a["x"], that
is, a table indexed by the string "x". The second form is a table indexed by the value of the variable x.

> a = {}
> x = "y"
> a[x] = 10
> a[x] -->10
> a.x -->nil
> a.y -->10
]]

--[[
Table constructors:
1. empty constructor: {}
2. initialize a list : {"Sunday", "Monday", "Tuesday", "Wednesday"}
(the first element of the constructor has index 1, not 0))
3. initialize a record : a= {x = 10, y = 20} , equivalent to
a = {}; a.x = 10; a.y = 20

We can mix record-style and list-style initializations in the same constructor
Those two constructor forms have their limitations. For instance, we cannot initialize fields with negative
indices, nor with string indices that are not proper identifiers

4. general format ：
We explicitly write each index as an expression, between square brackets.
Both the list-style and the record-style forms are special cases of this more general syntax.

{x = 0, y = 0} <--> {["x"] = 0, ["y"] = 0}
{"r", "g", "b"} <--> {[1] = "r", [2] = "g", [3] = "b"}

]]

days = {"Sunday", "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday"}
print(days[4]) --> Wednesday

polyline = {color="blue",
            thickness=2,
            npoints=4,
            {x=0,   y=0},    -- polyline[1]
            {x=-10, y=0},    -- polyline[2]
            {x=-10, y=1},    -- polyline[3]
            {x=0,   y=1}    -- polyline[4]
}
print(polyline[2].x)--> -10
print(polyline[4].y)--> 1

opnames = {["+"] = "add", ["-"] = "sub", ["*"] = "mul", ["/"] = "div"}
i = 20; s = "-"
a = {[i+0] = s, [i+1] = s..s, [i+2] = s..s..s}
print(opnames[s])--> sub
print(a[22])--> ---

-- read 10 lines, storing them in a table
a = {}
for i = 1, 10 do
    -- a[i] = io.read() -- read 10 lines of text
    a[i] = "line " .. i
end
-- print the lines, from 1 to #a
for i = 1, #a do
    print(a[i])
end

--[[
Table Traversal:
We can traverse all key–value pairs in a table with the 'pairs' iterator:
Due to the way that Lua implements tables, the order that elements appear in a traversal is undefined.
]]
--print('====')
t = {10, print, x = 12, k = "hi"}
for k, v in pairs(t) do
    print(k, v)
end
-- For lists, we can use the 'ipairs' iterator
-- In this case, Lua trivially ensures the order.
for k, v in ipairs(t) do -- only 10 and print
    print(k, v)
end

t = {10, print, 12, "hi"}
for k, v in ipairs(t) do
    print(k, v)
end

--Another way to traverse a sequence is with a numerical for:

t = {10, print, 12, "hi"}
for k = 1, #t do
    print(k, t[k])
end


--[[
Safe Navigation for nested tables (to avoid access to a nil table reference)

-- below performs six table accesses in a successful access, instead of three.
zip = company and company.director and company.director.address and company.director.address.zipcode

-- better way:
zip = (((company or {}).director or {}).address or {}).zipcode

-- or
E = {}  -- can be reused in other similar expressions
zip = (((company or E).director or E).address or E).zipcode

]]


-- The Table library
--[[
The table library offers several useful functions to operate over lists and sequences.
1. table.insert inserts an element in a given position of a sequence, moving up other elements to open space.
For instance, if t is the list {10, 20, 30}, after the call table.insert(t, 1, 15) it will become {15, 10, 20, 30}.
If we call insert without a position, it inserts the element in the last position of the sequence, without moving any element.
2. table.remove removes and returns an element from the given position in a sequence,
moving subsequent elements down to fill the gap.
When called without a position, it removes the last element of the sequence.
3. table.move (a, f, e, t) moves the elements in table a from index f until e (both inclusive) to position t.
(a move actually copies values from one place to another)
For instance, insert an element in the beginning of a list a
table.move(a, 1, #a, 2)
a[1] = newElement

The next code removes the first element:
table.move(a, 2, #a, 1)
a[#a] = nil

table.move can moves the elements from the first table into the second one.
For instance, table.move(a, 1, #a, 1, {}) returns a clone of list a (by copying all its elements into a new list),
while table.move(a, 1, #a, #b + 1, b) appends all elements from list a to the end of list b.

a stack structure:
push: table.insert(t, e)
pop: table.remove(t)

a queue: table.insert(t, e) , table.remove(t,1)
]]
--[[
t = {}
for line in io.lines() do
    table.insert(t, line)  -- input lines with ctrl-D for EOF
end
print(#t)
--]]
fruits = { 'apple', 'banana', 'orange', 'kiwi', 'grape'}
table.insert(fruits, 2, 'pear')
table.remove(fruits)
for k,v in ipairs(fruits) do
    print(k, v)
end

new_fruits = {}
table.move(fruits, 1, #fruits, 1, new_fruits)
print(#new_fruits)
table.sort(new_fruits)
table.move(new_fruits,1,#new_fruits, #fruits +1, fruits)
for k,v in ipairs(fruits) do
    print(k, v)
end