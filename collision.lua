
px, py = x, y --point coordinates
rec = { {x,y}; {x,y}; {x,y}; {x,y} }; --rectangle

function checkA ( x0, y0, x1, y1, x2, y2 ) --check point against line
	if ( x1*y2 - y1*x2 - x0*y2 + y0*x2 + x0*y1 - y0*x1 ) < 0 then return false end
end

function checkB( px, py, rec ) --check point against rectangle.
	if checkA( px, py, rec[1][1], rec[1][2], rec[2][1], rec[2][2] ) == false then return end
	if checkA( px, py, rec[2][1], rec[2][2], rec[3][1], rec[3][2] ) == false then return end
	if checkA( px, py, rec[3][1], rec[3][2], rec[4][1], rec[4][2] ) == false then return end
	if checkA( px, py, rec[4][1], rec[4][2], rec[1][1], rec[1][2] ) == false then return end
	return true
end

if checkB == true then
	--collision is true, perform action or anything else
end