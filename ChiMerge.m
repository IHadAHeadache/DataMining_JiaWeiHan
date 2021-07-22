flowers = readmatrix('./iris.csv');
flowers = sort(flowers);
max_interval = 6;
for i = 1:4
    values = [flowers(:,i) zeros(size(flowers,1),1) flowers(:,5)];
    class = 0;
    for j = 2:size(values,1)
        if(values(j,1) ~= values(j-1,1))
            class = class + 1;
        end
        values(j,2) = class;
    end
    while(values(size(values,1),2) >= max_interval)
        smallest_stat = 9999999;
        for k = 0:values(size(values,1),2)-1
            A = zeros(2,3);
            for ii = 1:2
                for jj = 1:3
                    if ii == 1
                        A(ii,jj) = size(values(values(:,2)==k&values(:,3)==jj,1),1);
                    else
                        A(ii,jj) = size(values(values(:,2)==k+1&values(:,3)==jj,1),1);
                    end
                end
            end
            A(3,1:3) = sum(A);
            A(1:3,4) = sum(A,2);
            chi_square = 0;
            for ii = 1:2
                for jj = 1:3
                    chi_square = chi_square + (A(ii,jj)-A(ii,4)*A(3,jj)/(A(3,4)+0.0001))^2/(A(ii,4)*A(3,jj)/(A(3,4)+0.0001)+0.0001);
                end
            end
            if(smallest_stat>chi_square)
                smallest_stat = chi_square;
                smallest_k = k;
            end
        end
        values(values(:,2)>smallest_k,2) = values(values(:,2)>smallest_k,2) - 1; 
    end
    flowers(:,i+5) = values(:,2);
end