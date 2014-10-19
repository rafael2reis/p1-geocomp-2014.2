local array_utils = require("array_utils")

local set_A = {
	[0] = {x = 0, y = 0},
	[1] = {x = 1, y = 0},
	[2] = {x = 2, y = 0},
	[3] = {x = 3, y = 0}
}

local set_B = {
	[0] = {x = 1.5, y = 1},
	[1] = {x = 1.8, y = 1},
	[2] = {x = 4, y = 1},
	[3] = {x = 5, y = 1},
	[4] = {x = 5.5, y = 1},
	[5] = {x = 5.9, y = 1}
}

local indice_P = 0
local indice_Q = 0

local m = 0
local n = 0

-- Estrutura de dados da CHE
local vetor_V = {}
local vetor_O = {}

function imprimeTriangulo(indice, triangulo)
	print("Triangulo " .. indice .. ":")
	io.write("\t(" .. triangulo[1].x .. ", " .. triangulo[1].y .. "), ")
	io.write("\t(" .. triangulo[2].x .. ", " .. triangulo[2].y .. "), ")
	print("\t(" .. triangulo[3].x .. ", " .. triangulo[3].y .. ")")
end

function proximoVerticeMenorEmX(set_P, set_Q)
	if (indice_P + 1) < m
		and (indice_Q + 1) < n then

		if set_P[indice_P + 1].x < set_Q[indice_Q + 1].x then
			indice_P = indice_P + 1
			return indice_P
		else
			indice_Q = indice_Q + 1
			return m + indice_Q
		end
	else
		if (indice_P + 1) >= m then
			indice_Q = indice_Q + 1
			return m + indice_Q
		else
			indice_P = indice_P + 1
			return indice_P
		end
	end
end

function triangle(set_P, set_Q)
	local nt = 0
	m = #set_P + 1
	n = #set_Q + 1

	local V = {}
	local O = {}
	for i=0,(n+m)*3 do O[i] = -1 end

	V[0] = 0 -- menor vértice em P
	V[1] = m -- menor vértice em Q
	V[2] = proximoVerticeMenorEmX(set_P, set_Q)
	nt = nt + 1

	while indice_P < m - 1
		or indice_Q < n - 1 do
		local he = nt * 3

		-- Definimos a orientação das half-edges
		-- fazendo a primeira half-edge de um triângulo
		-- indo de P -> Q
		V[he] = indice_P
		V[he + 1] = m + indice_Q
		V[he + 2] = proximoVerticeMenorEmX(set_P, set_Q)

		local j = he - 1
		-- Percorre o triângulo anterior para
		-- achar a half-edge que sai do vértice V[he + 1]
		while V[j] ~= V[he + 1] do j = j - 1 end
		O[he] = j
		O[j] = he

		nt = nt + 1
	end

	array_utils.print(V, "V")
	array_utils.print(O, "O")
end

triangle(set_A, set_B)