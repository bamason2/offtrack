classdef offtrack
% Aim: Identify test points for measurement of off track performance.
% 1)	Identify the x furthest points away from camtrack indices
% 2)	Cluster the neighbourhood of points around each centroid x
% 3)	Plot each off track cluster against the camtrack


%changelog
%----------------------------------------------
%24MAR20         BM      Initial specification.
%24MAR20         BM      Constructor and plotscatter method functionlity
%                        added. Track and index points hardcoded.
%27MAR20         RC      distance_idxpoints method, rank method and
%                        distance_clusters method, c


    
    
    properties 
        
        points              % all points from dataset defined as matrix with rows as
                            % cartesian coordinates [x, y]
        
        idxpoints =  [      % index points for analysis as matrix with rows as
                            % cartesian coordinates [x, y]
            0-15, 0; 
            0-15, 10;
            0-15, 25;
            0-15, 40;
            -15-15, 50;
            -25-15, 50;
            -35-15, 50;
            -40-15, 37.5;
            -45-15, 25;
            -28.5-15, 25;
            -15-15, 20;
            -5-15, 20;
            -15-15, 0;
            -5-15, 25;
            -26.75-15, 37.5;
            -30-15, 10
            ];
        
        numberpoints        % scalar value representing number points to cluster around centre
        
        track_11 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]';
        
        engine_label = 'Fox TT';
        
    end
        

    properties (Dependent)
    
        centres             %list of point centres and cluster of points around these

            
    end
    
    
    
    methods
        
        function obj = offtrack(inputdata)  
            %constructor method that creates object from data file. idx are
            %the reference index points in the cam space entered as a
            %matrix with rows as tuples representing cartesian x, y
            %coordinates. data is the filename with the data.
            
            % import index points
            %obj.idxpoints = table(idx(:,1), idx(:,2), 'VariableNames', {'ivo', 'evc'});
            


            % import relevant data points
            fields = {'VCT_CAM_ACT_INT','VCT_CAM_ACT_EXH',};
            
            data = load(inputdata);
            
            obj.points = table(data.(fields{1}).signals.values, data.(fields{2}).signals.values, 'VariableNames', {fields{1}, fields{2}});
        
        
        end

        
        function x = distance_idx(obj)
            % calculates distance between point x and y accepts an array as
            % arguments.  if x is a array a distance is calculated for
            % each point in the array relative to the point or group of
            % points specfied by y.  if a single argument is entered as a
            % array or scalar x then the distance is calculated with
            % reference to the index points.
            
            x = [obj.points.VCT_CAM_ACT_INT obj.points.VCT_CAM_ACT_EXH];

            rx = length(x);

            y = obj.idxpoints;

            ry = length(y);

            z = zeros(size(rx));

            for i = 1:rx
                dist = 0;
                for j = 1:ry

                    newdist = 1./(((y(j,1)-x(i,1))^2)+((y(j,2)-x(i,2))^2));
                    dist = dist + newdist;
                end
                z(i) = dist;
            end

            x = [x z'];
                    
               

                
            
        end
        
        function clusters = distance_cluster(obj) 
            % calculates distance between point x and y accepts an array as
            % arguments.  if x is a array a distance is calculated for
            % each point in the array relative to the point or group of
            % points specfied by y.  if a single argument is entered as a
            % array or scalar x then the distance is calculated with
            % reference to the index points.
            W = rank_t(obj);
            
            closest = zeros(20,4,20);
            A = zeros(20,4);

            for i = 1:20
                A(i,:) = W(1,:);
                W(1,:) = [];
                B = W;
                Q = A(i,:);

                dist = zeros(length(W),1);
                for j = 1:length(W)

                newdist = sqrt(((B(j,1)-A(i,1))^2)+((B(j,2)-A(i,2))^2));
                dist(j,1) = newdist;

                end

                B = [B dist];
                sorted_B = sortrows(B,5);

                for k = 1:20

                    closest(k,:,i) = sorted_B(k,1:4);

                end

                sorted_B(1:20,:)=[];
                sorted_B(:,5) = [];
                W = sorted_B;
            end

            clusters = closest(:,1:2,:);
                    
        end
        
        
        function rank = rank_t(obj) %#ok<MANU>
            %function to rank points based on distance
                     
            sorted_points = sortrows(distance_idx(obj),3);
            i = length(sorted_points);
            r = 1:i;
            rank = [sorted_points r'];

        end

        
    %plotting -------------------------------------------------------------
        function plotscatter(obj)  
            % scatter plot showing ivo/evc points and camtrack as defined by
            % idx points.  if idxpoints are not defined an error is thrown.
            
            plot(obj.points.VCT_CAM_ACT_INT, obj.points.VCT_CAM_ACT_EXH, '+')
            title('Cam position over cycle');
            xlabel('int'); ylabel('exh'); hold on;
            
            %plot cam track
            plot(obj.idxpoints(obj.track_11 + 1, 1), obj.idxpoints(obj.track_11 + 1, 2), 'r', 'LineWidth', 2); hold off;
        
        end

        function plotclusters(obj)  %#ok<MANU>
            % plot showing central point and circle with radius
            % representing distance of furthest point from centre.
            clusters = distance_cluster(obj);
            hold on
            for i = 1:20
                scatter(clusters(:,1,i),clusters(:,2,i))
            end
            title('Cam position over cycle');
            xlabel('int'); ylabel('exh');
            
            %plot cam track
            plot(obj.idxpoints(obj.track_11 + 1, 1), obj.idxpoints(obj.track_11 + 1, 2), 'r', 'LineWidth', 2); hold off;
            hold off
            
        end
        
        function plotiris(obj)  %#ok<MANU>
            % plot showing central point and circle with radius
            % representing distance of furthest point from centre.
            
        end
        
        
        
        function plotarea(obj)  %#ok<MANU>
           %plot showing area covered by clusters of points relative to total 
           % area covered by all points.
            
        end
        
        
        
    % get and set methods for dependant properties -----------------------
        
        function obj = get.centres(obj)
            
            %obj.centres = something
            
        end
        
    end
    
    
    
    % static methods (not sure if we need these) --------------------------
    methods(Static)
        
        
        
        
    end
     
    
    
end