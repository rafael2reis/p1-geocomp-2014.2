local array_utils = require("array_utils")

--Definimos os vetores V e O
--local V = { 0, 2, 7, 2, 5, 7 }
--local O = { "y", 5, "x", "z", "w", 1 }
--local he_flip = 5
local V = {0, 4, 1, 1, 4, 5, 1, 5, 2, 2, 5, 3, 3, 5, 6, 3, 6, 7, 3, 7, 8, 3, 8, 9}
local O = {-1, 3, -1, 1, -1, 6, 5, 9, -1, 7, 12, -1, 10, -1, 15, 14, -1, 18, 17, -1, 21, 20, -1, -1}
local he_flip = 3

function prev(he)
	return 3 * math.floor( he / 3 ) + (he + 2) % 3
end

function next(he)
	return 3 * math.floor( he / 3 ) + (he + 1) % 3
end

function flip(V, O, he)
	-- Vamos guardar os vetores
	-- da configuração antes do flip:
	local v_a = V[ prev( O[he] ) ]
	local v_b = V[ next( he ) ]
	local v_c = V[ prev(he) ]
	local v_d = V[ he ]

	-- Armazenamos também as informações
	-- sobre as he opostas:
	local he_x = O[ next( O[he] ) ]
	local he_y = O[ prev( O[he] ) ]
	local he_z = O[ next(he) ]
	local he_w = O[ prev(he) ]

	-- Atualizamos os valores em V:
	V[ he ] 		= v_c
	V[ prev(he) ] 	= v_b
	V[ next(he) ] 	= v_a
	
	V[ O[he] ] 		= v_a
	V[ prev( O[he] ) ] = v_d
	V[ next( O[he] ) ] = v_c

	-- Atualizamos os valores em O:
	O[ next(he) ] = he_y
	O[ prev(he) ] = he_z
	O[ next( O[he] ) ] = he_w
	O[ prev( O[he] ) ] = he_x

	-- Atualizamos as opostas
	-- se elas existirem:
	if he_x ~= -1 then
		O[ he_x ] = prev( O[he] )
	end
	if he_y ~= -1 then
		O[ he_y ] = next( he )
	end
	if he_z ~= -1 then
		O[ he_z ] = prev( he )
	end
	if he_w ~= -1 then
		O[ he_w ] = next( O[he] )
	end

end

function toArrayComecandoEmZero(A)
	local novo = {}
	for i=1,#A do
		novo[i-1] = A[i]
	end

	return novo
end

function teste()
	local vetor_V = toArrayComecandoEmZero(V)
	local vetor_O = toArrayComecandoEmZero(O)

	print("Antes: ")
	array_utils.print(vetor_V, "V")
	array_utils.print(vetor_O, "O")

	flip(vetor_V, vetor_O, he_flip)

	print("Depois do flip: ")
	array_utils.print(vetor_V, "V")
	array_utils.print(vetor_O, "O")
end

teste()
