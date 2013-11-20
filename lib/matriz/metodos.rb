
def mcd(a,b)
	u = a.abs
	v = b.abs
	while (v != 0)
		s = u
		u = v
		v = s % u
	end
	u
end

def mcm(a,b)
	s = a * b / mcd(a,b)
	s
end
