local array_utils = require("array_utils")

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

function teste()
	local V = {[0]=0, [1]=2, [2]=7, [3]=2, [4]=5, [5]=7}
	local O = {[0]="y", [1]=5, [2]="x", [3]="z", [4]="w", [5]=1 }

	print("Antes: ")
	array_utils.print(V, "V")
	array_utils.print(O, "O")

	flip(V, O, 5)

	print("Depois do flip: ")
	array_utils.print(V, "V")
	array_utils.print(O, "O")
end

teste()
