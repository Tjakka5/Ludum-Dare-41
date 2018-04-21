local shape = {
   8, 1,
   9, 2,
   9, 3,
   11, 3,
   11, 0,
   13, 0,
   13, 6,
   14, 7,
   14, 10,
   13, 10,
   13, 12,
   9, 12,
   9, 10,
   8, 9,

   6, 9,
   5, 10,
   5, 12,
   1, 12,
   1, 10,
   0, 10,
   0, 7,
   1, 6,
   1, 0,
   3, 0,
   3, 3,
   5, 3,
   5, 2,
   6, 1,
}

for x = 1, #shape, 2 do
   shape[x] = shape[x] - 7
end

for y = 2, #shape, 2 do
   shape[y] = shape[y] - 6
end

return shape