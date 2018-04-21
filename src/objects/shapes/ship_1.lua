local shape = {
   8, 0,
   9, 1,
   9, 2,
   11, 2,
   12, 3,
   13, 4,
   13, 5,
   14, 6,
   14, 9,
   13, 9,
   12, 9,
   11, 9,
   9, 9,
   8, 8,

   6, 8,
   5, 9,
   3, 9,
   2, 9,
   1, 9,
   0, 9,
   0, 6,
   1, 5,
   1, 4,
   2, 3,
   3, 2,
   5, 2,
   5, 1,
   6, 0,
}

for x = 1, #shape, 2 do
   shape[x] = shape[x] - 7
end

for y = 2, #shape, 2 do
   shape[y] = shape[y] - 5
end

return shape