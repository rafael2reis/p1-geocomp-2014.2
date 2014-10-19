--- array_utils: 

local A = {}

-- Concatena o array t2 ao final de t1
function A.join(t1, t2)
 
   for k,v in ipairs(t2) do
      table.insert(t1, v)
   end 
 
   return t1
end

-- Imprime o array
function A.print(a, nome)
	print(nome .. " size = " .. #a)
	if nome ~= nil then
		print(nome .. " = ")
	end
	for i=0,#a do 
	  print(i, a[i])
	end
end

-- Imprime o array de objetos
function A.printO(a, nome)
	if nome ~= nil then
		print(nome .. " = ")
	end
	for index,value in ipairs(a) do 
	  print(index,value.indice, value.valor)
	end
end

-- Imprime o array no formato de conjunto:
-- nome = { a_1, a_2, a_3 .. a_n }
function A.printSet(a, nome)
	if nome ~= nil then
		io.write(nome .. " ")
	end
	io.write("= { ")
	for i = 1, #a do 
		io.write(a[i])
		if i < #a then
			io.write(", ")
		end
	end
	io.write(" }\n")
end

function A.subarray (values,i1,i2)
	local res = {}
	local n = #values
-- default values for range
i1 = i1 or 1
i2 = i2 or n
if i2 < 0 then
	i2 = n + i2 + 1
	elseif i2 > n then
		i2 = n
	end
	if i1 < 1 or i1 > n then
		return {}
	end
	local k = 1
	for i = i1,i2 do
		res[k] = values[i]
		k = k + 1
	end
	return res
end

return A