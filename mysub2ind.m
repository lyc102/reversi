function ndx = mysub2ind(siz,v1,v2)

ndx = double(v1);
ndx = ndx + (double(v2) - 1).*siz(1);