
h1 = 1/4*[1 2 1];
h2 = 1/16*[1 4 6 4 1];
h = h2;

% draw(beside(y0,beside(y1,beside(y2,beside(y3,x4)))))

% Getting information needed for report - pyenc (not py4enc) was
% defined for this purpose as well as pyienc where i is not 4 
[x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X,h);

% quantise pyramid 
step_X = 17;
num_stages = 4;
step = get_optimum_step(step_X, num_stages, X , h, 0.0001, 1);
ratios = get_equal_mse_ratios(num_stages, X);

stepA = step;
if num_stages >= 2
    stepB = step*ratios(2);
else
    stepB = 0;
end

if num_stages >= 3
    stepC = step*ratios(3);
else
    stepC = 0;
end

if num_stages >= 4
    stepD = step*ratios(4);
else
    stepD = 0;
end

X_discrete = quantise(X, step_X);
x1 = quantise(x1, stepA);
x2 = quantise(x2, stepB);
x3 = quantise(x3, stepC);
x4 = quantise(x4, stepD);
y0 = quantise(y0, stepA);
y1 = quantise(y1, stepB);
y2 = quantise(y2, stepC);
y3 = quantise(y3, stepD);

out1 = py1dec(x1,y0,h); % decoder output for single stage pyramid 
out2 = py2dec(x2,y0,y1,h);
out3 = py3dec(x3,y0,y1,y2,h);
out4 = py4dec(x4,y0,y1,y2,y3,h);

% draw(out4)


% Compare original image to discretised version and discretised output of
% 4-stage encoding process  
figure(1)
draw(X)
figure(2)
draw(X_discrete)
figure(3)
draw(out2)
figure(4)
draw(out4)

% Visual Comparisons 
% CONST. step size
% For all pyramid sizes the discretised version appears less pixellated than the
% direct discretised one however there is less variation in the tone across
% the clouds for larger pyramids
% 1-stage and 2-stage pyramids seem to be a good visual representation
% Pyramids give much better representation of clouds than direct
% discretisation - much smoother - better
% EQUAL MSE
% 1-stage pyramid: not as good as const. step size rep. - very patch clouds
% and colouration on wall of building adjacent to light hous2
% 2-stage pyramid: clouds more blurred than single stage case - clouds are
% blurred - more aesthetic than grainy direct discrete rep.
% 3-stage: clouds even blurrier
% 4-stage: basically just as blurry as 3-stage


