num_masses = 4;

varsfh = @(h) ocl.examples.mass_spring.vars(h,num_masses);
daefh = @(h,x,z,u,p) ocl.examples.mass_spring.dae(h,x,u);
pathcostsfh = @(h,x,z,u,p) ocl.examples.mass_spring.pathcosts(h,x,u);
gridcostsfh = @(h,k,K,x,p) ocl.examples.mass_spring.gridcosts(h,k,K,x);
gridconstraintsfh = @(varargin) [];

x0 = zeros(2*num_masses, 1);
x0(1) = 2.5;
x0(2) = 2.5;

x_lb = -4 * ones(2*num_masses, 1);
x_ub = 4 * ones(2*num_masses, 1);

u_lb = -0.5 * ones(num_masses-1, 1);
u_ub = 0.5 * ones(num_masses-1, 1);

bounds = ocl.Bounds();
bounds.set('x', x_lb, x_ub);
bounds.set('u', u_lb, u_ub);

x0bounds = ocl.Bounds();
x0bounds.set('x', x0, x0);

solver = ocl.acados.Solver(10, varsfh, daefh, gridcostsfh, pathcostsfh, gridconstraintsfh, ...
                           x0bounds, bounds, 'N', 30);
