function counts = count_of_shapes_16L(boundary)
% for getting count of different shapes in 16L database

counts = zeros(7,6); % 7 shapes 6 colors

counter = 0;
for intensity=1:255
    for c=1:6
        for obj_count=1:4
            matr = nchoosek(1:7,obj_count); % 7Cx
            for i=1:size(matr,1)
                perm = perms(matr(i,:));
                for j=1:size(perm,1)
                    for k=1:size(perm,2)
                        counts(perm(j,k),c) = counts(perm(j,k),c) + 1;
                    end
                    counter = counter + 1;
                    if( counter >= boundary)
                        break;
                    end
                end
                if(counter >= boundary)
                    break;
                end
            end
            if( counter >= boundary)
                break;
            end
        end
        if(counter >= boundary)
            break;
        end
    end
    if(counter >= boundary)
        break;
    end
end

counter % to make sure loops are broken at correct counter

shapes = {'triangles', 'rectangles1', 'rectangles2', 'diamonds', 'hexagons', 'pantagons', 'circles'};

colors_ = {'Red','Green','Blue','Yellow','Magenta','Cyan'};

array2table(counts,'RowNames',shapes,'VariableNames',colors_)

end