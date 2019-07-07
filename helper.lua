function TableDelete(tbl, i)
	local size = #tbl
	for a=i,size-1,1 do
		tbl[a] = tbl[a+1]
	end
	tbl[size] = nil
end
function CleanNils(l)
	local tbl = {}
	for _,v in pairs(l) do
		tbl[#tbl + 1] = v
	end
	l = nil
	return tbl
end