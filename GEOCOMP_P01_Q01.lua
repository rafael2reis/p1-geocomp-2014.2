local array_utils = require("array_utils")
local sort_utils = require("sort_utils")

-- Definimos os pontos X[i]Y[i]
local X = { 0, 1, 2, 3, 1.5, 1.8, 4, 5, 5.5, 5.9 }
local Y = { 1, 1, 1, 1, 0, 0, 0, 0, 0, 0 }

local indice_P = 0
local indice_Q = 0

local m = 0
local n = 0

-- A partir dos pontos informados, cria
-- dois conjuntos, um para cada valor de y, 
-- colocando cada ponto i informado
-- numa estrutura { x = X[i], y = Y[i]}
function montaConjuntoDePontos(pontos_X, pontos_Y)
	if #pontos_X ~= #pontos_Y then
		print("Quantidade de pontos X diferente de Y!")
	else
		local set_A = {}
		local set_B = {}

		local y_A = pontos_Y[1]

		local indice_A = 0
		local indice_B = 0

		for i=1,#pontos_X do
			if pontos_Y[i] == y_A then
				set_A[ indice_A ] = {x = pontos_X[i], y = pontos_Y[i]}
				indice_A = indice_A + 1
			else
				set_B[ indice_B ] = {x = pontos_X[i], y = pontos_Y[i]}
				indice_B = indice_B + 1
			end
		end

		if y_A > set_B[0].y then
			return set_A, set_B
		else
			return set_B, set_A
		end
	end
end

-- Procedimento similar ao Merge do MergeSort:
-- Dados os conjuntos P e Q, retorna o
-- índice do menor elemento de P U Q

-- No retorno do índice, consideramos:
--	* índices de P variando de 0 até m - 1
-- 	* índices de Q de m até n - 1
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

function triangle(pontos_X, pontos_Y)
	local nt = 0

	-- O conjunto P será formado pelos pontos
	-- cuja ordenada_P > ordenada_Q
	local set_P, set_Q = montaConjuntoDePontos(pontos_X, pontos_Y)

	-- Ordenamos os pontos
	sort_utils.ordenaEmX(set_P)
	sort_utils.ordenaEmX(set_Q)

	m = #set_P + 1 -- Lua começa os arrays em 0. Precisamos
	n = #set_Q + 1 -- adicionar 1 ao valor do tamanho

	-- Estruturas de dados da CHE
	local V = {}
	local O = {}
	-- Inicializa vetor Opposite
	for i=0,(n+m)*3 do O[i] = -1 end

	V[0] = 0 -- menor vértice em P
	V[1] = m -- menor vértice em Q
	V[2] = proximoVerticeMenorEmX(set_P, set_Q)
	nt = nt + 1

	-- Enquanto existir ponto em P ou Q
	-- não utilizado na triangulação
	while indice_P < m - 1
		or indice_Q < n - 1 do
		-- índice da próxima half-edge a ser
		-- inserida na estrutura
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

triangle(X, Y)