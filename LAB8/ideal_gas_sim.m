function ideal_gas_sim
    %  Code to simulate MD for ideal gas molecules. Note the following:
    % - N non-interacting particles in a 3D cubic box.
    % - Collisions only with walls (particles bounce elastically).
    % - Pressure from total momentum transfer to walls.
    % - Compare simulated P vs. T to ideal gas law: P = (N/V) * kB * T.

    clear; clc; close all;

    %% Parameters
    N = 100;                 % num of particles
    box_size = 3.0;          % length of cubic box
    mass = 1.0;              % Particle mass
    kB = 1.0;                % Boltzmann constant ( we have set it to 1 here for convenience)
    dt = 0.01;               % time step of the simulation
    n_steps = 3000;          % num. of simulation steps
    target_temperatures = linspace(0.5, 5.0, 10);  % Temp. range
    wall_area = 6 * box_size^2;  % Total surface area of the cubic box

    %% Allocate array to store pressure
    pressures = zeros(size(target_temperatures));

    %% Loop over each temperature to perform MD at each temp
    for t_idx = 1:length(target_temperatures)
        T = target_temperatures(t_idx);

        % run MD at this temp.
        [pressures(t_idx), positions_history] = simulate_ideal_gas( ...
            T, N, box_size, mass, n_steps, dt, kB, wall_area);

        % show a visualization of the MD for the last temp. 
        if t_idx == length(target_temperatures)
            figure('Name','Particle Animation','Color','w');
            for step_i = 1:size(positions_history, 1)
                scatter3( positions_history(step_i, :, 1), ...
                          positions_history(step_i, :, 2), ...
                          positions_history(step_i, :, 3), ...
                          15, 'filled' );
                axis([0 box_size 0 box_size 0 box_size]); axis square;
                xlabel('X'); ylabel('Y'); zlabel('Z');
                title(sprintf('Positions at time step = %d', step_i*10));
                drawnow;
                pause(0.02);
            end
        end
    end

    %% Compare P-T data results from the sim w/ the ideal gas law: P = (N * kB * T) / V
    % (kB=1 and V=box_size^3, therefore P_ideal = (N * T) / (box_size^3))
    volume = box_size^3;
    P_ideal = (N .* target_temperatures) / volume;

    %% Plot results
    figure('Name','Pressure vs Temperature','Color','w');
    plot(target_temperatures, pressures, 'ro-','LineWidth',1.5,'MarkerSize',8);
    hold on;
    plot(target_temperatures, P_ideal, 'bx-','LineWidth',1.5,'MarkerSize',8);
    xlabel('Temperature (T)');
    ylabel('Pressure (P)');
    title('Pressure vs Temperature: Simulation vs Ideal Gas Law');
    legend('Simulated Pressure','Ideal Gas (PV = Nk_BT)','Location','best');
    grid on;

end 


function [pressure, positions_history] = simulate_ideal_gas( ...
                T, N, box_size, mass, n_steps, dt, kB, wall_area)
    % IDEAL GAS SIMULATION
    % -------------------------------------------------------
    % This function simulates an ideal gas in a box for n_steps at temperature T
    % Returns:
    %   pressure          
    %   positions_history
    
    % fix a random seed reproducibility
    rng(1);

    % initialize particle positions uniformly in the box
    positions = box_size * rand(N, 3); 

    % initialize velocities from the Maxwell–Boltzmann distribution
    % YOUR CODE HERE #1
    
    velocities=sqrt((kB*T)/mass).*randn(N,3);

    % store positions every 10 steps. We will use this for visualization 
    save_interval = 10;
    n_save = floor(n_steps / save_interval);
    positions_history = zeros(n_save, N, 3);
    save_counter = 1;
    
    % store total momentum transfer
    total_momentum_transfer = 0;

    % Simulation loop
    for step = 1:n_steps
        % update positions
        % YOUR CODE HERE #2
        positions=positions+velocities*dt;
        
        % check particle collisions with the walls in each dimension
        for dim = 1:3
            % gas particles hitting the left wall at x=0 (or y=0, z=0)
            mask_left = (positions(:, dim) < 0);
            % reflect position if the particle has gone beyond the boundary
            positions(mask_left, dim) = -positions(mask_left, dim);
            % momentum transfer to the wall: 2*m*|v|
            total_momentum_transfer = total_momentum_transfer ...
                + 2 * mass * sum(abs(velocities(mask_left, dim)));
            % flip velocity after the particle is reflected
            velocities(mask_left, dim) = -velocities(mask_left, dim);

            % gas particles hitting the "right" wall at x=box_size (or y=box_size, z=box_size)
            % YOUR CODE HERE #3
            mask_right = (positions(:, dim) > box_size);

            % reflect position
            % YOUR CODE HERE #4
            positions(mask_right, dim) = 2*box_size-positions(mask_right, dim);
            
            % momentum transfer
            % YOUR CODE HERE #5
            total_momentum_transfer = total_momentum_transfer ...
                + 2 * mass * sum(abs(velocities(mask_right, dim)));
            
            % flip velocity
            % YOUR CODE HERE #6
           velocities(mask_right, dim) = -velocities(mask_right, dim);


        end

        % save positions periodically
        if mod(step, save_interval) == 0
            positions_history(save_counter, :, :) = positions;
            save_counter = save_counter + 1;
        end
    end

    % calculate final pressure
    %    P = (Total momentum transfer) / (Total time * Wall area)
    simulation_time = n_steps * dt;
    pressure = total_momentum_transfer / (simulation_time * wall_area);
end