function [c, ceq] = constraintCircle(x)
    [~, ~, ~, ~, ~, circleParam, Lmin] = getGlobalParameters();
    % bifurcation must belong to the circle centered of the circumscribed
    % circle
    % the radius is the radius of the circumscribed circle - Lmin (stay at
    % at least Lmin from closest point)
    
    % convert to µm to help constraints (otherwise too close to numerical
    % precision)
    
    x = x*1e6;
    circleParam.r = circleParam.r*1e6;
    circleParam.coord = circleParam.coord *1e6; 
    Lmin = Lmin*1e6;
    
    c = (x(1)-circleParam.coord(1))^2 + (x(2)-circleParam.coord(2))^2 - (circleParam.r-Lmin)^2;
    c = c*1e-6;
    ceq = [];
end