local shape = {
   7, 1,
   8, 0,
   9, 1,
   9, 3,
   11, 3,
   12, 4,
   11, 5,
   11, 7,
   12, 8,
   11, 9,
   9, 9,
   9, 11,
   8, 12,
   7, 11,

   5, 11,
   4, 12,
   3, 11,
   3, 9,
   1, 9,
   0, 8,
   1, 7,
   1, 5,
   0, 4,
   1, 3,
   3, 3,
   3, 1,
   4, 0,
   5, 1,
}

for i = 1, #shape do
   shape[i] = shape[i] / 2
end
   
for x = 1, #shape, 2 do
   shape[x] = shape[x] - 3
end
   
for y = 2, #shape, 2 do
   shape[y] = shape[y] - 3
end

return shape