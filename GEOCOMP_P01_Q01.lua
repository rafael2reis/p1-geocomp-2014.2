
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

function min(set_P, indice_P, set_Q, indice_Q)
	if set_P[indice_P].x < set_Q[indice_Q] then
	else
	end
end

function triangle(set_P, set_Q)
	local m = #set_P
	local n = #set_Q
	print("m = " .. m .. " n = " .. n)

	local indice_P = 1
	local indice_Q = 1

	local set_T = {}
	set_T[1] = min(set_P, indice_P, set_Q, indice_Q)
	set_T[2] = min(set_P, indice_P, set_Q, indice_Q)

end

triangle(set_A, set_B)