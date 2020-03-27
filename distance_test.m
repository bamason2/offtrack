

x = [a.points.VCT_CAM_ACT_INT a.points.VCT_CAM_ACT_EXH];

[rx, cx] = size(x);

y = a.idxpoints;

[ry, cy] = size(y);

z = zeros(size(rx));

for i = 1:rx
    dist = 0;
    for j = 1:ry
        
        newdist = sqrt(((y(j,1)-x(i,1))^2)+((y(j,2)-x(i,2))^2));
        dist = dist + newdist;
    end
    z(i) = dist;
end

x = [x z'];