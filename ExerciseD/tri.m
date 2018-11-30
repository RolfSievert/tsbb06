function [ xb ] = tri(y1, y2, C1, C2)
    %x1 = pinv(C1)*y1;
    %x2 = pinv(C2)*y2;
    %xb = (x1+x2)/2;
    
    B = [
        liu_crossop(y1(:,1))*C1; 
        liu_crossop(y2(:,1))*C2];
    
    
    
    [U S V] = svd(B);
    
    xb = V(:,4) / V(4,4);
    
end

