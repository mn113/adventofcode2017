# optimised assembly instructions:

a,b,c,d,e,f,g,h = *[1, 106700, 123700, 2, 2, 1, 0, 0]

begin # loop affecting g, e, d, b, h
  begin # loop affecting g, e, d
    e = 2
    begin # loop affecting g, e
      g = d * e - b
      if g == 0 then f = 0 end
      e += 1
      g = e - b
    end while g != 0 # ends with g == 0, f == 0
    d += 1
    g = d
    g -= b
  end while g != 0

  # requires f, b, c:
  if f == 0 then h += 1 end
  g = b - c
  if g == 0 then break p h end
  b += 17
end while 1 # until it breaks



# Version 2:

# In a range of 17,000 integers, taking steps of 17, how many are non-prime?
a,b,c,d,e,prime,g,h = *[1, 106700, 123700, 2, 2, 1, 0, 0]
while b < c do
  prime = true
  lim = Math.sqrt(b).round
  for d in (2..lim) do
    for e in (lim..b) do
      if b == d * e then prime = false end
    end
  end

  if prime then h += 1; p h end
  b += 17
end
p h



# Version 3: speedy enough

require 'prime'
n = 106700
while n <= 123700 do
	if !n.prime? then h += 1 end
	n += 17
end
p h	# 905
