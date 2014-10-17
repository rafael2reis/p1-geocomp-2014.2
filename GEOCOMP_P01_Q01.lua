
local set_A = {
	{x = 0, y = 0},
	{x = 1, y = 0},
	{x = 2, y = 0},
	{x = 3, y = 0}
}

local set_B = {
	{x = 1.5, y = 1},
	{x = 1.8, y = 1},
	{x = 4, y = 1},
	{x = 5, y = 1},
	{x = 5.5, y = 1},
	{x = 5.9, y = 1}
}

local indice_P = 0
local indice_Q = 0

function imprimeTriangulo(indice, triangulo)
	print("Triangulo " .. indice .. ":")
	io.write("\t(" .. triangulo[1].x .. ", " .. triangulo[1].y .. "), ")
	io.write("\t(" .. triangulo[2].x .. ", " .. triangulo[2].y .. "), ")
	print("\t(" .. triangulo[3].x .. ", " .. triangulo[3].y .. ")")
end

function proximoPontoMenorEmX(set_P, set_Q)
	if (indice_P + 1) <= #set_P
		and (indice_Q + 1) <= #set_Q then
		if set_P[indice_P + 1].x < set_Q[indice_Q + 1].x then
			indice_P = indice_P + 1
			return set_P[indice_P]
		else
			indice_Q = indice_Q + 1
			return set_Q[indice_Q]
		end
	else
		if (indice_P + 1) > #set_P then
			indice_Q = indice_Q + 1
			return set_Q[indice_Q]
		else
			indice_P = indice_P + 1
			return set_P[indice_P]
		end
	end
end

function triangle(set_P, set_Q)
	local m = #set_P
	local n = #set_Q
	print("m = " .. m .. " n = " .. n)

	local set_T = {}
	local novo_T = {}
	novo_T[1] = proximoPontoMenorEmX(set_P, set_Q)
	novo_T[2] = proximoPontoMenorEmX(set_P, set_Q)
	if novo_T[1].y == novo_T[2].y then
		if indice_P == 0 then
			indice_P = indice_P + 1
			novo_T[3] = set_P[indice_P]
		else
			indice_Q = indice_Q + 1
			novo_T[3] = set_Q[indice_Q]
		end
	end
	imprimeTriangulo(1, novo_T)

	local j = 2
	while indice_P < #set_P
		or indice_Q < #set_Q do

		novo_T[1] = set_P[indice_P]
		novo_T[2] = set_Q[indice_Q]
		novo_T[3] = proximoPontoMenorEmX(set_P, set_Q)

		imprimeTriangulo(j, novo_T)
		j = j + 1
	end
end

triangle(set_A, set_B)