function[h1,h2,h3,h4,h5,h6,h7] = ego_vehicle_model(ego_px,ego_py,ego_head,ego_length,ego_width,backegde_to_center)
half_width = ego_width/2;
half_length = ego_length/2;
  shift_vec = [(half_length-backegde_to_center)*cos(ego_head)
                    (half_length-backegde_to_center)*sin(ego_head)];
  % backegde_to_center is to the constructor's center is rear axis center
  % Now we calculate the real center of the box
  center = [ego_px + shift_vec(1)
            ego_py + shift_vec(2)];   

point_rfx = center(1) -0.5*ego_length*cos(ego_head)-half_width*sin(ego_head);
point_rfy = center(2) -0.5*ego_length*sin(ego_head)+half_width*cos(ego_head);
point_rrx = center(1) -0.5*ego_length*cos(ego_head)+half_width*sin(ego_head);
point_rry = center(2) -0.5*ego_length*sin(ego_head)-half_width*cos(ego_head);
point_ffx = center(1) + 0.5*ego_length*cos(ego_head)-half_width*sin(ego_head);
point_ffy = center(2) + 0.5*ego_length*sin(ego_head)+half_width*cos(ego_head);
point_frx = center(1) + 0.5*ego_length*cos(ego_head)+half_width*sin(ego_head);
point_fry = center(2) + 0.5*ego_length*sin(ego_head)-half_width*cos(ego_head);
framePlot = [   point_rfx,point_rrx,point_frx,point_ffx,point_rfx
                point_rfy,point_rry,point_fry,point_ffy,point_rfy];
axle_rlx = ego_px -0*cos(ego_head)-0.8*half_width*sin(ego_head);
axle_rly = ego_py -0*sin(ego_head)+0.8*half_width*cos(ego_head);
axle_rrx = ego_px -0*cos(ego_head)+0.8*half_width*sin(ego_head);
axle_rry = ego_py -0*sin(ego_head)-0.8*half_width*cos(ego_head);
axle_flx = ego_px +2*cos(ego_head)-0.8*half_width*sin(ego_head);
axle_fly = ego_py +2*sin(ego_head)+0.8*half_width*cos(ego_head);
axle_frx = ego_px +2*cos(ego_head)+0.8*half_width*sin(ego_head);
axle_fry = ego_py +2*sin(ego_head)-0.8*half_width*cos(ego_head);
axlePlot = [axle_rlx,axle_rrx
            axle_rly,axle_rry
            axle_flx,axle_frx
            axle_fly,axle_fry];
tyre_rlx1 = axle_rlx +0.2*cos(ego_head)-0*sin(ego_head);
tyre_rly1 = axle_rly +0.2*sin(ego_head)+0*cos(ego_head);
tyre_rlx2 = axle_rlx -0.2*cos(ego_head)-0*sin(ego_head);
tyre_rly2 = axle_rly -0.2*sin(ego_head)+0*cos(ego_head);

tyre_rrx1 = axle_rrx +0.2*cos(ego_head)-0*sin(ego_head);
tyre_rry1 = axle_rry +0.2*sin(ego_head)+0*cos(ego_head);
tyre_rrx2 = axle_rrx -0.2*cos(ego_head)-0*sin(ego_head);
tyre_rry2 = axle_rry -0.2*sin(ego_head)+0*cos(ego_head);

tyre_flx1 = axle_flx +0.2*cos(ego_head)-0*sin(ego_head);
tyre_fly1 = axle_fly +0.2*sin(ego_head)+0*cos(ego_head);
tyre_flx2 = axle_flx -0.2*cos(ego_head)-0*sin(ego_head);
tyre_fly2 = axle_fly -0.2*sin(ego_head)+0*cos(ego_head);

tyre_frx1 = axle_frx +0.2*cos(ego_head)-0*sin(ego_head);
tyre_fry1 = axle_fry +0.2*sin(ego_head)+0*cos(ego_head);
tyre_frx2 = axle_frx -0.2*cos(ego_head)-0*sin(ego_head);
tyre_fry2 = axle_fry -0.2*sin(ego_head)+0*cos(ego_head);

tyrePlot = [tyre_rlx1,tyre_rlx2
            tyre_rly1,tyre_rly2
            tyre_rrx1,tyre_rrx2
            tyre_rry1,tyre_rry2
            tyre_flx1,tyre_flx2
            tyre_fly1,tyre_fly2
            tyre_frx1,tyre_frx2
            tyre_fry1,tyre_fry2];  
h1 = plot(framePlot(1,:),framePlot(2,:),'-k','LineWidth',1.5);
h2 = plot(axlePlot(1,:),axlePlot(2,:),'-k','LineWidth',1.5);
h3 = plot(axlePlot(3,:),axlePlot(4,:),'-k','LineWidth',1.5);
h4 = plot(tyrePlot(1,:),tyrePlot(2,:),'-k','LineWidth',1.5);
h5 = plot(tyrePlot(3,:),tyrePlot(4,:),'-k','LineWidth',1.5);
h6 = plot(tyrePlot(5,:),tyrePlot(6,:),'-k','LineWidth',1.5);
h7 = plot(tyrePlot(7,:),tyrePlot(8,:),'-k','LineWidth',1.5);
end