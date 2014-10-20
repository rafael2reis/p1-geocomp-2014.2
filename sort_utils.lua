local array_utils = require("array_utils")

local S = {}

-- main mergesort algorithm
function S.mergeSort(A, p, r)
        -- return if only 1 element
	if p < r then
		local q = math.floor((p + r)/2)
		S.mergeSort(A, p, q)
		S.mergeSort(A, q+1, r)
		S.merge(A, p, q, r)
	end
end
 
-- merge an array split from p-q, q-r
function S.merge(A, p, q, r)
	local n1 = q-p+1
	local n2 = r-q
	local left = {}
	local right = {}
	
	for i=1, n1 do
		left[i] = A[p+i-1]
	end
	for i=1, n2 do
		right[i] = A[q+i]
	end
	
	left[n1+1] = {x = math.huge}
	right[n2+1] = {x = math.huge}
	
	local i=1
	local j=1

	for k=p, r do
		if left[i].x <= right[j].x then
			A[k] = left[i]
			i=i+1
		else
			A[k] = right[j]
			j=j+1
		end
	end
end

function S.ordenaEmX(A)
	S.mergeSort(A, 0, #A)
end

return S