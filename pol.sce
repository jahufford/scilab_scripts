function y = pol(mag,ang)
    y = complex(mag*cos(ang),mag*sin(ang));
endfunction

function ang = angle(arg)
    ang = atan(imag(arg),real(arg));
endfunction

function fr=freqresp(h,sr)
     //sr = sr*2;
     if length(sr)==1 then
        w = -%pi:1/sr:(%pi- (1/sr));
     else
        w = sr;
     end     
     fr = zeros(1,length(w));
     for k = 0:(length(h)-1)
         fr = fr + h(k+1)*%e^(-%i*w*k);
     end
endfunction

function cgrid(varargin)
    if length(varargin) == 0 then
       mtlb_axis([-2.5,2.5,-2.5,2.5]);
   else
       mtlb_axis(varargin(1));
    end

    xgrid(6)
endfunction


// I changed the order of the parameters
// draw line from a to a+b
function line_seg(a,b,varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    plot([real(a);real(a+b)],[imag(a);imag(a+b)],c(1));
endfunction

// draw line from a to b
function line_seg2(a,b,varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    plot([real(a);real(b)],[imag(a);imag(b)],c(1));
endfunction

function cplot(z,varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    for i = 1:length(z)
        plot([0;real(z(i))],[0;imag(z(i))],c(1));
//      plot([x1;x2],[y1;y2],c(1d));
    end
endfunction

function vplot(x,y,v)
    plot([x;x+real(v)],[y;y+imag(v)])
endfunction

// take an array of points and draw them as a curve
function draw_curve(points,varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    for i=2:length(points)
        line_seg2(points(i-1),points(i),c)
    end
endfunction

// take an array of points and draw them as a curve, and close the curve
// by drawing a line between the first and last points. 
function draw_closed_curve(points,varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    for i=2:length(points)
        line_seg2(points(i-1),points(i),c)
    end
    line_seg2(points($),points(1),c);
endfunction

function cclf(varargin)
    //clf;
    delete(gca());
    disp(varargin);
    if length(varargin) > 0 then
        cgrid(varargin(1));
    else
        cgrid();
    end
endfunction

function freqphaseplot(h,sr)
    f = freqresp(h,sr);
    for i = 1:length(f)
        cplot(f(i));
    end
endfunction


function draw_figure(points, varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    for i = 1:length(points)-1
        line_seg2(points(i),points(i+1),c)
    end
    line_seg2(points($),points(1),c)
endfunction

function draw_circle(radius, center_point, num_points, varargin)
    c = 'b';
    if length(varargin)>0 then
        c = varargin(1);
    end
    th = 2*%pi/num_points;
    points = [0:th:2*%pi];
    points = translate(radius*%e^(%i*points), center_point );
    draw_figure(points,c);
endfunction

function y=translate(a,v)
    y=a+v
endfunction

function y=rotate(a,p,r)
    y = translate(translate(a,-p).*%e^(%i*r),p);
endfunction