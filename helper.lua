function CleanNils(l)
	local tbl = {}
	for _,v in pairs(l) do
		tbl[#tbl + 1] = v
	end
	l = nil
	return tbl
end